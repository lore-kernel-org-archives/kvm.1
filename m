Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8E035C19D
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 03:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780974049; cv=none; b=Ip9VrCl/5sxmCJNsg+mur+H+sPMhAmNRf209STyCBbY0NpzJUf/CMf4VJ8yuh1K6LHbeY+2rIPCm/ihiM73A9rbzQkH+dpWJkHdyPqYnsmGsqLmqS6Dw8OsgfK5y/xvehwMGwW/Yp+hHHp9Xc7RY2XIGiKlSs8ev9MWOpy9XX1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780974049; c=relaxed/simple;
	bh=Gd5jVtuJQiQ7JlAEfSo8CzJBlq/O8FT63MLf3/NDo1w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YPSZL6mHh/B24wROGrxS/BxU64qhrz44vDk9OIsZrZ9X91cGrw18n58rzHpNs3YCebT2Oc5eTccmPX8thUyICByabQGJE1uAnVeFYs1/q4DiwDPmMYvxeqC8lpLwC/d/OjlGMrwjyIsfycK2ySgfpQAlWbtj4wutrLCEItPOD5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FfQyXUJN; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FfQyXUJN"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c85a2c0b56fso4495684a12.0
        for <kvm@vger.kernel.org>; Mon, 08 Jun 2026 20:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780974038; x=1781578838; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kT6zNJuN43ARIxYKIBqAoaKHU3qYmWXT0x+9LehhU2o=;
        b=FfQyXUJN/vsSoIkdM2tqNNoG4Nt9SbAzJvUIMp5B1Mf+XkyGp/biCY03wmYr63YjPy
         7m9smUewPHrho7aJVB3LsyH6NmvvbM4gIsHdBc4usTY/cMvWTKmoyNAAkzulsRvdQosS
         K2zSfGnJPyDOm3FnTMVBnZChXYUm9pleOtEtfotTBX8MdQpDAXTRGL5uWVhdGQgS0YDP
         IAR0LLxdhhd1ofJX3l3ymyiQHRlI2reZCv8CccvXQNAFVwbdAiWfww5y/aos0yI5bqD1
         gmJNh+M/FJuXTAq/zFSCgVD4Hhh7sKhAnAUn9wRds+7gOoBZtByOoQ5+qStx2gkP+9Jy
         xUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780974038; x=1781578838;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kT6zNJuN43ARIxYKIBqAoaKHU3qYmWXT0x+9LehhU2o=;
        b=Dlt10gbJM0SAyddC8hgkiupr/nW+RzaNkls6kRkWCdvtheVno4IIoj1P2wp9a9Er8q
         whdQLtmLDgPcKQVvKituFosUjrvNRIv1WTz+p5B00uV8FAfqKvCnGI2ejxBkNDci4uEW
         OXQaxUNuyw0WCQdYFomEM73oNHG8oo6YjnnUPkkolK/hVkCkgdzjsjkxty+zbwHcnEpQ
         SsKCn7cfUSwZF31/U4eaKEzZ7NUqUtNj0ql/Ovb9FXT1ahdw0LvgvuMzflibq7ct72aR
         72pdkOpRHne7p1TSy2lp+cM4e9MqwPB92tdDS9FldiflW/hZvp7x3AgPi9uguMGa7FVO
         Sr5g==
X-Forwarded-Encrypted: i=1; AFNElJ+ad1Bd7d4pI1ainxaULGsZAZ3jfiUaO0Sd9Cb4VLnsoBRIQXkcjoH48AjEJTaiEMrKWH4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8u7h2aWDaImfaXC+KYP6OyWrhZh4pVwH6Xmemg4laO/Qhhv86
	ZXngxC2kN1ZBetsBIBr4e1YVx5k8lSI9FHoi5MKrrnTmvopVjtaL11xyE/mKXoZAf5wavvZRakW
	6HJ0Qyg==
X-Received: from pgc17.prod.google.com ([2002:a05:6a02:2f91:b0:c82:35ce:8939])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3949:b0:38b:eadd:449a
 with SMTP id adf61e73a8af0-3b4cd042933mr21709786637.38.1780974037611; Mon, 08
 Jun 2026 20:00:37 -0700 (PDT)
Date: Mon, 8 Jun 2026 20:00:36 -0700
In-Reply-To: <cb8d64e6-dfc6-4984-a46a-157e57e55aaf@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
 <20260417073610.3246316-2-binbin.wu@linux.intel.com> <4e5b6b9c-4f7d-4d62-874a-4bcb745e9a47@linux.intel.com>
 <aibPZMfxabh6meOk@google.com> <cb8d64e6-dfc6-4984-a46a-157e57e55aaf@linux.intel.com>
Message-ID: <aieB1E_nVyO5vOTk@google.com>
Subject: Re: [RFC PATCH 01/27] KVM: x86: Fix emulated CPUID features being
 applied to wrong sub-leaf
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, rick.p.edgecombe@intel.com, 
	xiaoyao.li@intel.com, chao.gao@intel.com, kai.huang@intel.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 09, 2026, Binbin Wu wrote:
> On 6/8/2026 10:19 PM, Sean Christopherson wrote:
> > On Mon, Jun 08, 2026, Binbin Wu wrote:
> >>
> >>
> >> On 4/17/2026 3:35 PM, Binbin Wu wrote:
> >>> Guard the use of cpuid_func_emulated() with a check that the CPUID
> >>> sub-leaf index is 0, as cpuid_func_emulated() unconditionally returns
> >>> emulated features for index 0 and does not account for indexed leaves.
> >>>
> >>> Without the guard, when iterating over reverse_cpuid[] entries that
> >>> share the same CPUID function but have a non-zero index, e.g.
> >>> CPUID_7_1_ECX (function=7, index=1), the emulated features for index 0
> >>> are incorrectly OR'd into the wrong capability word.  For example,
> >>> RDPID (CPUID.7.0:ECX[22]) gets erroneously applied to CPUID_7_1_ECX,
> >>> which would allow userspace to set bit 22 of CPUID.7.1:ECX in the vCPU's
> >>> capabilities.
> >>>
> >>> This is currently benign as the affected bits in the non-zero index
> >>> words happen to not correspond to meaningful features, but it could
> >>> cause problems as new features are defined in those positions.
> >>>
> >>
> >> Hi Sean/Paolo,
> >>
> >> While the bug is currently benign, I still think it's worth fixing.
> >>
> >> There could be two options:
> >> - Considering cpuid_func_emulated() probably would not be extended
> >>   in the future, still keep this simple implementation, but add some
> >>   comments to cpuid_func_emulated() to call out only subleaf 0 is emulated
> >>   as suggested by Xiaoyao.
> >>   https://lore.kernel.org/kvm/fa47d520-1de9-4ddc-94ca-6bb53ac30f10@intel.com/
> >> - Add the index input parameter to cpuid_func_emulated().
> > 
> > Definitely handle this in cpuid_func_emulated().
> 
> Thanks, the diff looks good to me.
> I will send a separate patch for this.
> 
> BTW, do you want to provide your SOB?

Nah, you did the hard part, claim it as your own.
