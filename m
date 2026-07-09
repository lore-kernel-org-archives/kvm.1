Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F092B3B7B8B
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 19:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783625248; cv=pass; b=fJbQ48Bbutejnl2zJPDmsIUUT5wtx284gl0oEKp8XQP9pcl2GJyGIB7+TfT4vrDnfUiQ4DUmJwdD6lUU2ZOiBFXt209pfgGN33p3/fm1LaDanihN45muPOI4hwQakWZIQPdtImaM8Ufty/igrUvgCSyFlZABRG+1M4u7krHcCx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783625248; c=relaxed/simple;
	bh=rFm8Ygno+BsK+0G1CsSFXZBS42iO/5RIV18Ghl0Clgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H+ucmU5JpUGDhRvPLUyXzjLhJDzzg86Odpg8FHs83sQgaIOZSsJ0/NWF576jrpmvf1alpsPdtojRTVyReRc0/xprEfCBiJgYYPDSgRh4JtUPKSNVlTZRnKtTnvkIgaPt0ps0uoU9SL339IyTkW73MaiR0/aBif4IuYDd3Af7sXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G4g3kDHa; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G4g3kDHa"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aeb6bdeaeaso1401e87.0
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 12:27:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783625245; cv=none;
        d=google.com; s=arc-20260327;
        b=J+RX6eYDUUlH137GagcKoKv9PYJ4R1YdhvmnST+OypaqonWmB5fjTkQ7G9ovcpqZzv
         2SBx2UYPH1t14Ftav8l16j/z3D+KTtn6nXzS0gsYz0FoytsOFuDEi/hWI8TiATnoxIm7
         KPeaPqR0DVIyvJiCZ9fXoEh63/nOYgcmtmRnO5b41WI7ZIN4yax9yu/H0QiJ4xoe+PP3
         xojC5I6gpfFYh4/m4VyBRqbbgNEp2w4wFruXtQbnbr5L/NmCdYU5Iu6Njw2IwCW9Sa5d
         FgMEMjq3SYfeONLixSSy2Az9PowgTpXRL5vaPK4fyp0jwmzQc0DnyZGnIHZKJJu898GD
         KOKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QeasUUn+gjdu9isr720YSr9OdEALSAsIQjhv2qGp/vs=;
        fh=fItrUtV5UsY1KSNx1ZNnzv3miYMbODbRRQWQ18AP5Zc=;
        b=du23DOHvR1xUA7RhVdxjznpOtivKMIRdnQk8nkAqCkj/o0f0IfDsZkUzWS+S7HiT6N
         stU9TDq0WYEGz1m4h2TjbZVk/DLhin0QS5GX0MqvJQ4pFnn8KqSb3syD16fMlmDYKRi2
         qUOYbxQWzH66tJAXsX3oXxTLr09PAOiYzMpjZi/oG/cXeGd/5G+5dSL+GpB860QZxrMQ
         xFSujXS635/nRgXv8RftV6aL3dItDUV8/SDvBEz0UhTxsNksUX14zWQR0QIcbvhi5dQt
         +/jGvSyPuDReqn6qHOA/lZwhm2MyE9RiO8fKogiXNmPdldff2CJxgIHHsVEPTGEFLJHT
         rDHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783625245; x=1784230045; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QeasUUn+gjdu9isr720YSr9OdEALSAsIQjhv2qGp/vs=;
        b=G4g3kDHaTXxc8HLhH2A7iwSgex1vPNRewBnzdi3z64dB93DvyGacJQgZTkS3yiR/VH
         ea3Z+keGFL41KtHCIV90QIZXdZpAT5tluGkZsU5vYeASL1GqXPd15ujhqAX30R0hUWJy
         /ezrQgJr5XI7304n1JR9mezthghcJ4K+p+0sp4V/AUCBYLPUGgdPwf35g6AFHqrBUhMl
         mHHypMaNRaP4cuvfUjFv4KXlrg6pnHbWKhhufgLoJDaGklAZRXL7uPxkdS6+QQnnlp3u
         E6BAfy6dU/Mdnvfd8GwADvfprMvQCI+Dey9+r/Pa/HpncegZ26msGfyTaA1Yc1Nf6X/f
         ZH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783625245; x=1784230045;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QeasUUn+gjdu9isr720YSr9OdEALSAsIQjhv2qGp/vs=;
        b=GGAKZl/pb2ybQwaAOaGV+vBNnqJaRmA89PISRQdA3jSspYfpYlqX3Mh5Bahq7bpGNZ
         vL555hwCSaQ2uLLfmoi4lMiwKFIpWVT5KK+kMU0wcvLIHQOdDQLu/MDVsmlENlWTIjxT
         sQKl/H3Dj5Hq3sNnvOnWTQ+T5YgTBXckaU+cXxv1LG0+g1z2EJPktcDymymqBOWmN4RE
         53jPT6ndu3pyd0GkvTyu2qjlH+cMKhfJn3p9gJSOYqcD548Tdqa5ajHnAoJpDWPNNyuj
         UtmcO5lW6JdMZM+7kiOM94Lujy/2beFIGx5GFFRjUhGdPWLzk2R5A+ygQ/MQzvgsLCdu
         Wrkg==
X-Gm-Message-State: AOJu0Yy6+DhNMolROEdIWhhtazIs6DTWWx7xTiwFk59J4aIpw8/O9cC/
	hShizJygcHHqzTRHh44yRzrtugDMPr3QL33in5iv6k4P6zdZWVU6g2g1kABP/oE6exCw3stJBPh
	j7LKMKy5r8FLIzOkdUYSJ8DqI9czQjFnMXPcrdFc=
X-Gm-Gg: AfdE7ckRDWNoQyT2igRM76N7l9yCyAwNLAZHEfW4HMxL6qXCBYGUZkDUdBHYcqDPP0p
	3s5dPQNT+9p/3oK7ft01Y+rveHUbwnsjuyfezvShUUN9kwFyn6VXjA74NEGziWlxgoAcaWwGQov
	YfcDg8Q7VsjyGKOFTbaVxQDDHRiMig4fryxS6lH2cRlWnNAxTf+oJDNoG7Ft1iTclxDLxxoERPC
	vQkURQUD6k/oBYVBAXFMBueBok8IEmLiQ4bX53ShPmzKvfAX6C10lyyrSgudji+3zhc
X-Received: by 2002:a05:6512:1324:b0:5ae:b59b:c65e with SMTP id
 2adb3069b0e04-5b01c5cdcdcmr31389e87.4.1783625244688; Thu, 09 Jul 2026
 12:27:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708-igb_v3_b4-v3-0-1272650ca614@google.com>
 <20260708-igb_v3_b4-v3-2-1272650ca614@google.com> <20260708232808.184BD1F000E9@smtp.kernel.org>
In-Reply-To: <20260708232808.184BD1F000E9@smtp.kernel.org>
From: Josh Hilke <jrhilke@google.com>
Date: Thu, 9 Jul 2026 12:27:12 -0700
X-Gm-Features: AVVi8Ccd9CIfVYUXuByu-1VzHQ6_1RCBW4NsLsV_vmNKVvn4uyCUkBnvop3DQiQ
Message-ID: <CAAdrzjsxv-neCiK0qCUsRnei5oY7sieuSLa=Yu+ajJLUF=MxKw@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] vfio: selftests: igb: Use PHY internal loopback on 82576
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 4:28=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The commit message incorrectly references removing and keeping=
 macros and code that do not exist in the baseline or the patch diff.
> --
>
> --- Patch [2]: [PATCH v3 2/9] vfio: selftests: igb: Use PHY internal loop=
back on 82576 ---
> commit 2d54b65042a5cbe6702c330df52d94e7c2ff3b57
> Author: Alex Williamson <alex.williamson@nvidia.com>
>
> vfio: selftests: igb: Use PHY internal loopback on 82576
>
> This commit replaces igb_phy_setup_autoneg() with igb_setup_loopback() to=
 use
> PHY internal loopback on the 82576 device instead of MAC loopback, aligni=
ng
> with the datasheet requirements for real hardware. It forces the MAC into=
 1Gb/s
> full duplex with link up to ensure the descriptor engine runs. The patch =
also
> maintains compatibility with QEMU's emulated igb behavior without needing
> environment-specific code paths.
>
> > The submitted driver also wrote bit 14 (link disable) to PHY register
> > 16 (port control).  Datasheet 3.5.6.3.1 describes this as required for
> > 10/100Mb/s but explicitly "not a must for 1G", and the kernel ethtool
> > selftest omits it.  It is dropped here.  Flagging the removal in case a
> > future regression bisects to this commit.
> >
> > Remove igb_read_phy() and the PHY status macros it served, which become
> > unused: IGB_PHY_STATUS_REG_OFFSET, IGB_PHY_STATUS_AN_COMP.  Keep
> > IGB_PHY_CTRL_AN_ENABLE and IGB_PHY_CTRL_AN_RESTART for the QEMU-only
> > autoneg kick; add the PHY ctrl loopback and CTRL force-link macros.
>
> [Severity: Medium]
> This isn't a bug in the code, but the commit message references removing =
and
> keeping macros and code that do not exist in the baseline or the patch di=
ff.
>
> Looking at the baseline code being modified, igb_phy_setup_autoneg() did =
not
> write to PHY register 16. It also used standard macros like MII_BMCR and
> BMSR_ANEGCOMPLETE rather than IGB_PHY_STATUS_REG_OFFSET,
> IGB_PHY_STATUS_AN_COMP, or IGB_PHY_CTRL_AN_ENABLE.
>
> Could this part of the commit message be a leftover from an earlier versi=
on
> of the patch series?

Sashiko is correct here. In v3, I updated the first patch in the
series to import the real IGB headers, so the macros are now
different. I'll update the commit message accordingly for v4.
