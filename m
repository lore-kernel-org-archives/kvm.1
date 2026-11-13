Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794563322;
	b=UgkLJptMw0aUCI3ft7Uuzr1yKEHEKnMbJOt2bH+vq5AvvCo+qnnYfAx9PGtj5pFB02Wm
	 x782s3cg251nmILpV94OiSiGblR6CVcSRKRF0KhK2OHQnU3qMKErVMDnQEeudFFVwSKQB
	 vLzq11VQdRiXWl5ugTOvCq9J54F16bNGCP72hLJiUqm8LMZ74lr6k5oS6sue2bjvVj4/3
	 aUk+/JKb+Cw4gRjwu1uKAA17g3JtzFEaCQg2P5989k7tnhVL4Eh1zFoOSFmDjAJsyi7oe
	 WMXCLBeDrlTTQ77HSwBosaZCIyDmMELYbTW4paaBgAIhyDvwQtEq92+uOL3MK4XShXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563322;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=SZEm3fBRIvJbx/BoWtbu1KusfNuPE7i14QPaGaBXJ5E=;
	b=fipS+tlib3YC+rVLhO0O/Pf5AwIBLFytXGXWHgbDeLwf/PEKIpstxsuVNdey6i4Knpif
	 DYJwrMeRttmoITmeb/W1wabeY7WGuDV8DgSE8+VHLn3qH++ED6fFXxMHA6khlKJGkCUJn
	 v2/SPnAN1g0Tgx4VvQRVMELNwj23U9z0XdpH+uGnQmrU1RIN+9KrZjk1F7YnjxfnZevhW
	 Y+f4lKNChX6pI4lbLwM28yp7muF/LPQ5N+16yG0k6KY4Mau6NzZx9wK9scJxvwYc5DNJE
	 2Dxa2jMZUUb0na/KInYh9GM9qB/kb5+LOS5ArymHY4ZQvPP/RizJI1zPLb9Gduq46fg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jv77Clb1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.49
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E13606A33D
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 09:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07E13606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jv77Clb1
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-70bf1671c21so1048514eaf.1
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 01:48:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794563321; cv=none;
        d=google.com; s=arc-20260327;
        b=CoTzoHY+6A9PcySRZwmNRzgNVVBwy1f5WoJ21sTQ53CcWMMQ3k/xyx4ZxzEwqc8z6i
         SyZcB8uEiXPUjskMvoyQwb/AyLYkhYQx8Xjg4UfdkCtGfoy441nplceoU/OL+8Ff20Sq
         Q98QBeVgT7avmWWWjbXyFxu7MX7Y2jdSXH4LHQkn2N+qjVgi4xsek9zcO0xbczbV8bTS
         kSAG7ux/DuvOSbkhAXY5nL+e2+61b6SglA/wxfyM7fNyAngSClkNLXfRvRM40t9zjWEF
         k8dfQqpgZwScqU/2kHdwxTrQC6l1vTA5AQGLlB2MAgsYAcLiY6MsR4QLAH/pfKZwjQ9P
         K9tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SZEm3fBRIvJbx/BoWtbu1KusfNuPE7i14QPaGaBXJ5E=;
        fh=VIQbPElQ+TYY5gmJ69Z2IPfJRLKM0ev4+sxP6eMUAAo=;
        b=n1nmPRgKb8MXoRjWeQLBPI4/VhlUhK3Bxa59Rvs8H/xSUmlF88op2rF0vLbnRXccCM
         kVDTTv/ZCCF7RTmtyDqSgBZwlDrXYW+xjJpIhXf1LBbrBOerrBT6IpdlZ96Yn5TGQm2h
         j0rbqy9sZRMcLXd3bYqmJoIRB5HR4OapCL9sZwYvVb5ryvapehDGf+LVMwS1ufpCract
         HLV3xV5q1a6ONPcIrRstIP9cDYiKzCNENTX3WIrpIgcqIxno6YfNA0XNBaO7gRuFSRIg
         vaqbJlkuYnp/OziSusadE0ofCRt5w4e3G/6Xk9wvLw/x4TwXOxpQRphWxIa7TqF0+IR7
         jd3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794563321; x=1795168121; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SZEm3fBRIvJbx/BoWtbu1KusfNuPE7i14QPaGaBXJ5E=;
        b=jv77Clb13lyuOqIjfiPS4p3fXoGEBr/EhJKexqlJumu8TakGoQRHQSBu9VNTqY979M
         mBzvJE2kp8LOUyV0glvz4daiW66b3K22lGfcWn5dvn2rmdw6vdvs55770WG1GT2LR+sf
         R88zBeZC4Cf60w6SseDwdh/QWr+XMQVJ2AJfGwYffw1AcyXdvKS1ocNsZ3r6NAf8ZDb8
         oeExpn2kpemfprrC4LEWEkTQ6nY3ZwuD0MXjVNCKxGDpWrwk1oK5ULF99p7qxJVZAswi
         lPOPbIH8qUfHl9GizztqYlIkp2dFvN6M0bHK/JrVQ+swanTeD1pU7lvmMP5CunXAQ/dw
         MlmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794563321; x=1795168121;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SZEm3fBRIvJbx/BoWtbu1KusfNuPE7i14QPaGaBXJ5E=;
        b=j5wOnqrdeUqnO6JZ/d1IExlP+06grJ5tTDJalOFdb1u9rGdQ+YNyjbGMFm8tDdizFi
         Hcz1+OQj9IGEfIMyRx2alMkJhXwtg3cbxSA50svebLZKzuKjLG/Tv+DXxuKR9gOVE7l/
         MwTzpHwmZB3X7X0YvXPPzwyoDJAwuo07UqFZ7vnX/lEw9vp54zQsK465nztJvvZTc0WN
         L4QtkQKa0U3H/vpkBfeVMiw9pCoahkQOhXckVQAnw5rV/n2abG+D1ndou1LQq4vhhAR4
         eb3OMIkj+jU19ztC8poDBkDRTx/EucGBZGis0Jzuwzfm1dv6iGr8OvKPVtcyfFH7AITu
         1gOg==
X-Forwarded-Encrypted: i=1; AL+hErFID2Pus1j1J8E2kEp6CqAT3ehAv1yTEm9BZ0B6t54By3czj+6ACbkXCGtCzjdQjHIGs88=@vger.kernel.org
X-Gm-Message-State: APuU4Z93qrOA4pwki3kdvb8FGXUdpbAksEmAXspYu1fFviBsAs5VTra1
	BL+0ssjAjK7/w0BnngENGbne30aoiWvNOIEgZEsAJMfJHnP2VlrkiR4bHAt1Y2lGxG1ag7b2rgR
	svISqXnmIY6VQoIduuNcGHLK/a2ienr0=
X-Gm-Gg: AYBFou10ts6wYyYRQPoPq+6+Q3P/P49GvpopLFs5rXX+qrDxsWUinHoxQB766i9WEjv
	C9V37sHIEUQRGN4atMkSJnDk4tQnNE6m+TdmEOeellQieHl76M5E2oTF+p+M6VL3/yVXIefimt7
	TbIk+ZnPJ+iQcEIYyRIi2Nyn06NUZT65n+sJd0bWuz1/OiJ1C56WufJr6zd+hc2i/vkZfgVkPOb
	k46X/NyvyGj65teSuJiwqgkeYh3s01AT7XbdYy8ktfG48s9r1bag8081je11nd5qDOy9tqCsMJZ
	W5ru5zql9sBiNSZMiuuIXnpmQe995tOIxIl3S5q4tDWJrZjWWy7KDyUOfqV+CJgPu6SqKH37yCh
	Z3ELhz/ZHAOX9HZoFAAIBioW0/g+RP0XGiMP3yHK2urLLLMbyc+0DjS6xMF9G
X-Received: by 2002:a05:6820:6fc4:b0:716:e2c3:e48 with SMTP id
 006d021491bc7-71ab50e864emr1017445eaf.58.1794563320647; Fri, 13 Nov 2026
 01:48:40 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260821201432.879450-1-Ashish.Kalra@amd.com>
In-Reply-To: <20260821201432.879450-1-Ashish.Kalra@amd.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Fri, 13 Nov 2026 10:48:29 +0100
X-Gm-Features: AclHuK-l_3UXJP1eTJDtPvdLhfXvgmrVR8-YQaX4h4dQv4VKuNhz7ofGxIqEsbY
Message-ID: <CAM9Jb+hD1Pq_fT7Km23vxTKf43MHUn0g5s1ue453WuN817gLBA@mail.gmail.com>
Subject: Re: [PATCH] x86/sev: Skip DR7 write during kexec when it would
 trigger an unserviceable #VC
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Srikanth Aithal <Srikanth.Aithal@amd.com>, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	"Gupta, Pankaj" <pankaj.gupta@amd.com>
Content-Type: text/plain; charset="UTF-8"

> machine_kexec() calls hw_breakpoint_disable(), which writes DR7. On
> SEV-ES/SNP guests that do not have DebugSwap enabled, DR7 accesses are
> intercepted and delivered to the guest as a #VC exception, which must be
> serviced through the GHCB.
>
> By the time machine_kexec() runs, snp_kexec_finish() (called from
> native_machine_shutdown()) has already converted the per-CPU GHCBs and
> the boot GHCB back to private and set boot_ghcb to NULL, tearing down the
> GHCB infrastructure. The DR7 write therefore raises a #VC that
> dereferences a NULL GHCB pointer, causing a page fault and the kexec to
> fail.
>
> The NULL boot_ghcb pointer is a result of commit 3645eb7e3915 ("x86/fred:
> Fix early boot failures on SEV-ES/SNP guests"): that change makes
> __sev_get_ghcb() return the now-NULL boot_ghcb in this window, turning
> the previously-benign teardown-window #VC (a bogus VMGEXIT the host
> rejected but survived) into a NULL dereference.
>
> Skip the DR7 write in this case. Its value is not needed across kexec
> because the new kernel re-initializes DR7. Guests with DebugSwap enabled
> context-switch DR7 in hardware and do not intercept the write, and
> non-encrypted guests are unaffected, so both continue to call
> hw_breakpoint_disable() as before.
>
> Add a CC_ATTR_GUEST_DEBUG_VIRT confidential-computing attribute, so the
> debug-register-virtualization state (AMD DebugSwap) is queried through
> cc_platform_has().
>
> Reported-by: Srikanth Aithal <Srikanth.Aithal@amd.com>
> Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
> Fixes: 3074152e56c9 ("x86/sev: Convert shared memory back to private on kexec")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> Tested-by: Srikanth Aithal <Srikanth.Aithal@amd.com>

I stumbled upon this issue while testing kexec on SNP on 7.4rc2.

I confirm this patch fixes issue for me.

Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Tested-by: Pankaj Gupta <pankaj.gupta@amd.com>

Best regards,
Pankaj
