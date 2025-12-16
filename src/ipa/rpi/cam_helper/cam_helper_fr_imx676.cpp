/* SPDX-License-Identifier: BSD-2-Clause */
/*
 * Copyright (C) 2024, Framos
 *
 * camera helper for imx676 sensor
 */

#include <math.h>

#include "cam_helper.h"

using namespace RPiController;


class CamHelperimx676 : public CamHelper
{
public:
	CamHelperimx676();
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

CamHelperimx676::CamHelperimx676()
	: CamHelper({}, frameIntegrationDiff)
{
}

uint32_t CamHelperimx676::gainCode(double gain) const
{
	int code = 20 * log10(gain) * 10/3;
	return std::max(0, std::min(code, 0xf0));
}

double CamHelperimx676::gain(uint32_t gainCode) const
{
	return pow(10, 0.015 * gainCode);
}

unsigned int CamHelperimx676::hideFramesStartup() const
{
	/* On startup, we seem to get 1 bad frame. */
	return 1;
}

unsigned int CamHelperimx676::hideFramesModeSwitch() const
{
	/* After a mode switch, we seem to get 1 bad frame. */
	return 1;
}

static CamHelper *create()
{
	return new CamHelperimx676();
}

static RegisterCamHelper reg("fr_imx676", &create);
