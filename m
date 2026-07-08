Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEBA14A60F
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 23:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783553289; cv=none; b=r+jlgoybn8LPZDg21Ot2apPlyfLx/ZrE+3YheS+GqOhIYHiA3AImOJfbocLovBOEYvi5wMQEQybBE8Nyaj4LdFc/Q7wLOreHViUjsW8pL9Un+lTDPxHTBhIiwNjWCboYwaJ1rKibIX0mbxpLkBP4WJR2v26d0fydMVad+Rjrxrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783553289; c=relaxed/simple;
	bh=KXTAqAVdOIzVjrsiS6JL1iruo7exjXQxpNRtIi0jc4E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OJRBkVSrkryh3pvfbIXBwKX8Puyna6LFQq4GnwGnNAx/VCg09jQVze1iEU6/6lMej178zJy5QaScZPK+2UaNI+TU9YqEWu1Hyc8v3AGvmCBQu0nlJiSCyRx8/9AMc1oHPJ4FjJXF5RdaWb13KzAyDm8w6gZ8RgF31+5DsCGOBjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfjs9d8l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfjs9d8l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184BD1F000E9;
	Wed,  8 Jul 2026 23:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783553288;
	bh=B2FA4JcL8TECUzTCOZcJ8Z7GKnvbcLhmFVoF3YgFWzc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dfjs9d8l+0NmNK73HfP7f3pL5B0OEi8j3OBXc3hmhbbE1OEn7jkJxfx4e0X3roe8j
	 9SxLkQUviIcwF/PuVc8TrdLXLQdvKafCGWKqYgUBGEYN8at7q0msTlM3EJ1IjzSYMx
	 65tsH6sWThR5X9+GtPNPcDLTy2g8qlsgN+qWNSthpOmZSVBcOozSvYgCo0jmkU5PZH
	 f6Mvs4Uix7RMFoafbaX/6sUQpeo+uJ7KECJgrx/wfOBmoRpFvlIrEmfldQ5eGOmUSK
	 wRji5fnTH8GWe/WVgUrav09gff7490cSp5Jrslxm6QgIYL5Q93KiShW1wh4o9cIdkt
	 GzHUoUoCR11qg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/9] vfio: selftests: igb: Use PHY internal loopback
 on 82576
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josh Hilke" <jrhilke@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260708-igb_v3_b4-v3-2-1272650ca614@google.com>
References: <20260708-igb_v3_b4-v3-0-1272650ca614@google.com>
 <20260708-igb_v3_b4-v3-2-1272650ca614@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 23:28:07 +0000
Message-Id: <20260708232808.184BD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message incorrectly references removing and keeping m=
acros and code that do not exist in the baseline or the patch diff.
--

--- Patch [2]: [PATCH v3 2/9] vfio: selftests: igb: Use PHY internal loopba=
ck on 82576 ---
commit 2d54b65042a5cbe6702c330df52d94e7c2ff3b57
Author: Alex Williamson <alex.williamson@nvidia.com>

vfio: selftests: igb: Use PHY internal loopback on 82576

This commit replaces igb_phy_setup_autoneg() with igb_setup_loopback() to u=
se
PHY internal loopback on the 82576 device instead of MAC loopback, aligning
with the datasheet requirements for real hardware. It forces the MAC into 1=
Gb/s
full duplex with link up to ensure the descriptor engine runs. The patch al=
so
maintains compatibility with QEMU's emulated igb behavior without needing
environment-specific code paths.

> The submitted driver also wrote bit 14 (link disable) to PHY register
> 16 (port control).  Datasheet 3.5.6.3.1 describes this as required for
> 10/100Mb/s but explicitly "not a must for 1G", and the kernel ethtool
> selftest omits it.  It is dropped here.  Flagging the removal in case a
> future regression bisects to this commit.
>=20
> Remove igb_read_phy() and the PHY status macros it served, which become
> unused: IGB_PHY_STATUS_REG_OFFSET, IGB_PHY_STATUS_AN_COMP.  Keep
> IGB_PHY_CTRL_AN_ENABLE and IGB_PHY_CTRL_AN_RESTART for the QEMU-only
> autoneg kick; add the PHY ctrl loopback and CTRL force-link macros.

[Severity: Medium]
This isn't a bug in the code, but the commit message references removing and
keeping macros and code that do not exist in the baseline or the patch diff.

Looking at the baseline code being modified, igb_phy_setup_autoneg() did not
write to PHY register 16. It also used standard macros like MII_BMCR and
BMSR_ANEGCOMPLETE rather than IGB_PHY_STATUS_REG_OFFSET,
IGB_PHY_STATUS_AN_COMP, or IGB_PHY_CTRL_AN_ENABLE.

Could this part of the commit message be a leftover from an earlier version
of the patch series?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-igb_v3_b4-=
v3-0-1272650ca614@google.com?part=3D2
