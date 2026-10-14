Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A668C373BFE
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 15:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791991957; cv=none; b=JtbseId1P5EK1oayjELW+Tj2OcmJT64gilaGF9Hs+AD1kCimwd37GCyXYUpNaCAQkSABpbRADHY9jhCt+HU2yoF08mtbTdS792CXLtAIH3UrDQ7ibkujujoI0Gdeol5Y4hhLxhxzUrNPfFcqs7WTgREFkC9Sp7x3ZTVyQAq0htU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791991957; c=relaxed/simple;
	bh=+YG6kwjw8swXv1cMy01c14Cvj9TuYMG4J2cF10Oo3YY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Df8Ro4mwTUWzFjYCo/aJRXTkOb+WBvxDHGUlFkCO51v9+Csgj/dFIocXg4NImSmn2YTjBGv7+7MCVwuYqZ0fBoQMB2D+JjY/Weka5fNzFKRIZDMjC9D8hm6/UUA6RP8lid3vj9BZZMkI8izgyEK9pirVGvcqShXG0D4lRieY1wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EmYFF1k/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H4ahJ2eq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EmYFF1k/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="H4ahJ2eq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791991954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mq81I6/6MELfTlSiNgJCcbSKdRE4LM8gKHiIeTsVVWs=;
	b=EmYFF1k/u5TYs+hm0HcDGh3T0hNdP6nBMFePwqGE96ay0pTA0zG86VnsHqgype/DVhIirj
	2v3Iw+O8XwdqCKElN9mBlAcMjAQ4OHouQeuT3Ewe1LyOALbPx5Z+o9PjhiSV5/Ll4eGWpT
	CD0kzunLcueN6fGdeImeuHvdmZE/0RI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-b6ZMdzQnPnS2ZcQCaWku9w-1; Wed, 14 Oct 2026 15:32:33 +0000
X-MC-Unique: b6ZMdzQnPnS2ZcQCaWku9w-1
X-Mimecast-MFC-AGG-ID: b6ZMdzQnPnS2ZcQCaWku9w_1791991952
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a1b11e7837so12617655e9.1
        for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 08:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791991952; x=1792596752; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Mq81I6/6MELfTlSiNgJCcbSKdRE4LM8gKHiIeTsVVWs=;
        b=H4ahJ2eq0IXcDyVDdVmksWa1aVsSFqBYRy1R4tBsBHHGarR4LiGAYLOU/VsPH7en/3
         PZjd5KSqKgnmTdeyILse+lzWOVWFItz9Txd4i8ODGBCIH6O+YJRDZCfEIt93Iwu4B8mA
         0apU0RcafO44ZjoMCmOV+EOatG7P0RQCVhHQ5OogmlCr1hvPo17iCxvN5u5DW+FNQYsQ
         CmLsm2Pn2nRHsvXsuU3DiFO2fnw/gIsloXcv8npX8WrZudSWBa4H/jky4MHXlyDirCQ1
         mabAfzSxLDW7vWxyvSDSl8tHHdLOLHUpAxkGZ2/0vt4+O3lS8jyl8FpZC2WKWjbt18cL
         l4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791991952; x=1792596752;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mq81I6/6MELfTlSiNgJCcbSKdRE4LM8gKHiIeTsVVWs=;
        b=v/dt7T1XTIoxS1jks3ZTkKBihGO6fDmI/Roq1IZLuOt9iHBZSyjC24eIN7WFP0Pwex
         1luMRu2vulC3PsZCtgQDUlmmF2xfYTanHBGihbpt7FWrJCdzkcnP0zF8oYIBcehlPs0h
         odDGYRjdjOk+5Bb0VK5G7g9y5goUjP1PyrriCaARVUwHB4MuNUfYThHiLI4/0jIgoBxo
         p9VO4v8IyqqDCojL+brwHXxe8LISYk45weCbL6xxGTCTqHu5xjqinmzCC/Bz/LyV62yg
         WVFAf9BYhP344XyyrYIRdgST0YZOsHt9jRRfB+zi65iFtGqWXqJ0U8Pv3QxXqoy2e2Ro
         keyA==
X-Forwarded-Encrypted: i=1; AKwUvBzXcYKQHs2ILQ1P8tQpaLucpWX6NT7wkeU409rklwFNE7C0kn4lXOReW5VyKpDHvyRFca4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIM8vW3aFtdPSr5KuxSdpLW5flDceE8O2C8w0Hg/kTf/3axPYMK
	DfNDEZpacR50HQNewVObuUCxXBhAfqMuwIlWP4CmlxUmCEw+QheMTKdZaQoCno/ypQxae2hob7G
	YX5hv9GYe4UvAowJGlWbMEp8REUMLa0Pktv1hhCa+ApXYiDflzp+gyA==
X-Gm-Gg: AYBFou2p6dQLjrz8179Y9RwgbSutM6L/ff4FWBtRTIR+VePKfi5uCxdQVKCQ1yxWnup
	udJW2z4O56vNXFC2YUfqRqhILrlqi6rlucIqfqqHS4pEGyiZZfl62sc74Bee8rtWXaFpS+KJRmC
	cAMuf94j0WzO6fRKii5fZ5UK6QDt0ToHxZZKEsioJ+v4aVWOVf/1QginiDW92uBPlf9Rur4fVNw
	97mP5eUn+/19bhxo4wNoKtSsh2xWVlx8cJQNZCdJJHVT7CJhvzMI7/Oc3aGQxYEmFWN3E4lhSBK
	ghzXUN49dVL+mCTyIyZqjFWZ6aZGRGqpEgJL0uwOPDM1bHf5K7vjIRodRA/VTFaYBEUK444C2sO
	RrFSWrVrxctYUVfB+L0QWDDia9MSGh7kqQ3A=
X-Received: by 2002:a05:600c:6289:b0:4a1:a475:d885 with SMTP id 5b1f17b1804b1-4a1a475d8acmr154443385e9.34.1791991951912;
        Wed, 14 Oct 2026 08:32:31 -0700 (PDT)
X-Received: by 2002:a05:600c:6289:b0:4a1:a475:d885 with SMTP id 5b1f17b1804b1-4a1a475d8acmr154442825e9.34.1791991951551;
        Wed, 14 Oct 2026 08:32:31 -0700 (PDT)
Received: from leonardi-redhat ([176.206.38.69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd66c5e6sm1215655e9.2.2026.10.14.08.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 08:32:30 -0700 (PDT)
Date: Wed, 14 Oct 2026 17:32:26 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
	Marcelo Tosatti <mtosatti@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v2 0/5] igvm/sev: apply the IGVM guest policy before
 launch
Message-ID: <as-gUPOHujXsPiWV@leonardi-redhat>
References: <20260907-fix_igvm_policy-v2-0-c8c50f1dbfda@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260907-fix_igvm_policy-v2-0-c8c50f1dbfda@redhat.com>

On Mon, Sep 07, 2026 at 05:56:56PM +0200, Luigi Leonardi wrote:
>The guest policy from an IGVM file never actually made it to the platform
>before launch. The callback that was supposed to forward it ran after
>LAUNCH_START, so it did nothing and the guest was launched with the
>default policy instead of the one requested by the file.
>
>The policy is part of the attestation report, so this quietly breaks
>attestation: the resulting measurement does not match what the IGVM file
>was built for.
>
>Patches 1 to 4 are cleanups needed to get there: dropping an overloaded
>callback, moving the SNP ID block handling, giving the policy properties
>proper accessors, and adding a way to read back the platform's current
>guest policy. Patch 5 is the actual fix.
>
>One thing worth calling out: if a policy is also passed on the command
>line and it differs from the IGVM one, the command-line value takes
>precedence and we print a warning instead of silently picking one over
>the other.
>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
>Changes in v2:
>- Rework the callback split. Now we don't have an unimplemented callback [Stefano, Gerd]
>- Reject a command-line/IGVM policy that doesn't fit in the 32-bit
>  SEV/SEV-ES policy field instead of truncating it [Stefano]
>- On a mismatch between the command-line and IGVM policy, print a warning and
>  keep the command-line value instead of returning an error. [Daniel,
>  Gerd, Stefano]
>- Picked up RoB
>- Rebased to latest upstream
>- Link to v1: https://lore.kernel.org/qemu-devel/20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com
>
>---
>Luigi Leonardi (5):
>      sev: split set_guest_policy into set_guest_policy and set_id_block
>      igvm: move set_id_block call into the SNP ID block directive handler
>      i386/sev: convert the guest policy properties to custom accessors
>      i386/sev: add a get_guest_policy callback
>      igvm/sev: forward the IGVM guest policy to the platform before launch
>
> backends/confidential-guest-support.c       |  24 +++-
> backends/igvm.c                             |  91 ++++++------
> include/system/confidential-guest-support.h |  36 +++--
> include/system/igvm-internal.h              |   3 -
> target/i386/sev.c                           | 215 ++++++++++++++++++----------
> 5 files changed, 230 insertions(+), 139 deletions(-)
>---
>base-commit: cacd3462963a0a4f5bab4263ce79c2aa4b32692d
>change-id: 20260831-fix_igvm_policy-0b92de52dd6a
>
>Best regards,
>-- 
>Luigi Leonardi <leonardi@redhat.com>
>

gentle ping :)

Thanks,
Luigi

