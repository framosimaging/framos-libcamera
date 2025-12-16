/* SPDX-License-Identifier: BSD-2-Clause */
/*
 * Copyright (C) 2024, Framos
 *
 * camera helper for imx900 sensor
 */

#include <math.h>

#include "cam_helper.h"

using namespace RPiController;


class CamHelperimx900 : public CamHelper
{
public:
	CamHelperimx900();
	uint32_t gainCode(double gain) const override;
	double gain(uint32_t gainCode) const override;
	unsigned int hideFramesStartup() const override;
	unsigned int hideFramesModeSwitch() const override;

private:
	/*
	 * Smallest difference between the frame length and integration time,
	 * in units of lines.
	 */
	static constexpr int frameIntegrationDiff = 2;
};

CamHelperimx900::CamHelperimx900()
	: CamHelper({}, frameIntegrationDiff)
{
}

uint32_t CamHelperimx900::gainCode(double gain) const
{
	int code = 20 * log10(gain) * 10;
	return std::max(0, std::min(code, 0x1E0));
}

double CamHelperimx900::gain(uint32_t gainCode) const
{

	return pow(10, 0.005 * gainCode);
}

unsigned int CamHelperimx900::hideFramesStartup() const
{
	/* On startup, we seem to get 1 bad frame. */
	return 1;
}

unsigned int CamHelperimx900::hideFramesModeSwitch() const
{
	/* After a mode switch, we seem to get 1 bad frame. */
	return 1;
}

static CamHelper *create()
{
	return new CamHelperimx900();
}

static RegisterCamHelper reg("fr_imx900", &create);
