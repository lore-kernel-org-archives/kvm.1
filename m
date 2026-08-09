Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD53223A562
	for <kvm@vger.kernel.org>; Sun,  9 Aug 2026 13:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786280774; cv=none; b=S6hrUPPwWp5kHjQblPL2Jo3+hd/wXvkgU+GY8ZY9AyIV5ZXUdQJHHw3Ri3esIvsb2WJ1EGDfQ4a8kgpxEbK3UrOyPXZQs+9tf7n4F90Qp+4+BLpJjvoop0oWA0nkzIdMiLBrIaX7H9xegAs/7RK+HCJ1ib90xsj/p4WzuIXFK+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786280774; c=relaxed/simple;
	bh=3/MwZ17UgDtbe1TGC2ytWfCtQ5mT/jF9A2Hk7ZwDJs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHuBAsob6L8LfVjT0ti/rJEbn6pljSKp4+JeM5SKItbU1a/Ud26edDhXjD+Jpz/c/qX0YAPItGrTck4g8Wif7XIglykoJ4tgKF61YT5vBjJfkokSfkbLJDEITkq2i332h+2EOa6f4DK8cl9g14lv3Zy50RyMz+LbWSS4ZyRBo+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S8yG3rnj; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S8yG3rnj"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8efb708b1a0so5066366d6.3
        for <kvm@vger.kernel.org>; Sun, 09 Aug 2026 06:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786280771; x=1786885571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x57uq5myqQEypV80yicD+m9k8ZSaT3RYYTsF64xqmQc=;
        b=S8yG3rnjMw+asl057MNUDpzAjb2KBffEE9MzjNATXaS1Eo2Qel4+BrWV/LQFx+rZYp
         gcXUniDL2rsX3r+ubA9FKoTvFVUKTMm5814xWI6IoDtGr7fF9cC8M7srrSEeMfb38Bej
         w3VFRdxXTk0ImngQHHzr7/ZYg5lU2mO4An/8bFWN/SCqOx8HQE/3dwcSdP2ugu+G25Ri
         wGuWTLlnRbU7KWmo9Z3NynVlB2f2kcLk77RVC5rHhFHUkSVjAdzb0bM126N+dqtp0LAr
         waehxToZ4d6qPNLJ3aUdefYcxVxLT7TGh0Y5FCuh8oMRdtOYP2afAUEtdBmqxZO/HNPl
         y9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786280771; x=1786885571;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x57uq5myqQEypV80yicD+m9k8ZSaT3RYYTsF64xqmQc=;
        b=mBPyWzOqEhSuMKRWsLPHCTy17tKlqIzdzXGODYlsElYKgpA7kBCubek7bB0L2YgzNw
         urfrd5Nzegg+LuoUjicu0zYvuNn2oYBiCTKxrsmZtb/ipXcWfj/eH8s+NIaeyEAb2rYq
         QeGBgS9W2phXAz2gRL0xxVEu5i3gVr3UIC9Nj4X0cxlapDX+F6NXmI+HMR0qbWJ7QxzV
         merYdQ6vpm/m2D4M93V/qui1HpvIOsj5INzr52hPm7uCOey/Kr0B5LTe/Ab1OUby+laY
         1MDu9w45+jSKBvGI/3F8/u1FlQnSOLK8StIZ2rj5MKTA9FerL0gHmRPuWcVfB/mXPmvy
         Gtng==
X-Forwarded-Encrypted: i=1; AHgh+Rpjud1LM+rrTT3CWjDDpIiUSDgwzZG4H2wBKXS6KCkhlc5G25jUAgRaNTkMYlmaRrx3/QM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2clGmrIGnnfaZyCfAQbJyxnKfzyGfWhj6oXhUs/0CHI3aS9+P
	vyTZXV06E46qkdRCISBBcnSIVTY1SfIg33DzeK+IMi2e7473RnLYF0YtrTChu78DmP4=
X-Gm-Gg: AR+sD13fJQuaD8QaZ4+THkl+/blc3xTz66K+tG9aWjSG/3ZNJ4m/m0kQn8smpRcX8RO
	taOuL9VQkvtGrHyqQGuBMdfO1VJWYvjVLPLRUFOrU2Yr5kn8r0eU4VrvacfdsrhYOiQhOcQ9Cjx
	oFCHhGdWAKaLPSnAybfFzSM/coKZy0s7O75vMvTrmb5k0J7KmGUbXlrD22ptEaXvL0MAxxwQOdv
	Nk4ItRFSZebmT2djAObyjh7d5B8cWt6AWndKVvoS7JTeK2UyLMqoKZm8aNUCTKrDnH/4y/YNcyS
	e9n7xen3rRHLaBPXKuiQdJSHQ7CUoiE/BQj9rBSPvKzK3XQ/Ia6aogcDSCB/HqtcjpJA8Xk53ua
	CWUjNTsaEPsa62JUncd+exneiYoDdcYoXtqQ9Lo11N5W+Y8OEua/19ivR+ZoPsQy6uEhDd0x3I/
	tuPrKTPTyisLQ5W9itpXG6RXai094HOWon3Ikf/5Rbi4jAibjMvkoYB3vjjTjs/g==
X-Received: by 2002:a05:6214:e8b:b0:8ef:b049:7e35 with SMTP id 6a1803df08f44-908813c46a4mr425056456d6.31.1786280771410;
        Sun, 09 Aug 2026 06:06:11 -0700 (PDT)
Received: from p14s ([161.184.159.159])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908a934e2fasm49519796d6.46.2026.08.09.06.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 06:06:10 -0700 (PDT)
Date: Sun, 9 Aug 2026 07:06:06 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Kohei Enju <enju.kohei@fujitsu.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
	mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
	eblake@redhat.com, armbru@redhat.com, lorenzo.pieralisi@linaro.org,
	gshan@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: Re: [RFC v2 00/24] Add Realm support to QEMU-VMM
Message-ID: <anh7Pk4dV51de7O0@p14s>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
 <amrYWWyWlhnN2Fll@FCCLS0092175.localdomain>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amrYWWyWlhnN2Fll@FCCLS0092175.localdomain>

On Thu, Jul 30, 2026 at 02:11:57PM +0900, Kohei Enju wrote:
> On 07/28 13:26, Mathieu Poirier wrote:
> > This patchset provides minimal functionality to start a Realm VM
> > from an Arm RME capable host using the following command line:
> > 
> > qemu-system-aarch64 \
> >  -M confidential-guest-support=rme0 -object rme-guest,id=rme0 \
> >  -cpu host -M virt -enable-kvm -M gic-version=3,its=on -nodefaults ..
> > 
> > It is a refactoring of Jean-Philippe Brucker's initial work dating from a while
> > back.  It is compatible with Steven Price's v14 revision [1] of his work adding
> > CCA support to KVM.
> > 
> > * We are currently working on rebasing the work to v15.
> > 
> > It was tested on the QEMU SBSA machine.  For convenience, a repository is hosted
> > here [2], along with the TF-A [3], RMM [4] and Linux kernel [5] for the SBSA
> > machine (compatible with Steven's v14 patchset).
> > 
> > Instructions to compile and run the entire stack can be found here [6].
> > 
> > Device Assignment is not included.
> > 
> > Thanks,
> > Mathieu
> 
> Hi Mathieu, thank you for your work on upstreaming CCA support. I've
> tested this series in QEMU-TCG(x-rme=on) environments and confirmed
> that the basic functionality works well.
> 
> I have a question about a QMP command for querying CCA capabilities.
> 
> Jean's tree contains the following commit adding such a QMP command. Was
> this functionality intentionally omitted from this series?
> https://git.codelinaro.org/linaro/dcap/qemu/-/commit/41f7852cc8590a38c47299a35a7238da09ff9a12
> 
> We are interested in adding this functionality because we are also
> planning to upstream CCA support for libvirt, which will need a QMP
> interface to query the CCA capabilities exposed by QEMU.
> 
> Since the Linux kernel dropped some configuration parameters such as the
> hash algorithm, I need to rework the implementation of that QMP command
> a bit. If it's okay with you, I'd be happy to send out the reworked
> patch based on this series.

I am currently away from the office - I will get back to you after August 17th.

> 
> Thanks,
> Kohei
> 
> > 
> > [1]. https://lore.kernel.org/kvm/20260513131757.116630-1-steven.price@arm.com/T/#m06dd14216aaf76acab65b0a76fb84653141ea64f
> > [2]. https://gitlab.com/Linaro/cca-public/qemu/-/tree/upstream-v2?ref_type=heads
> > [3]. https://gitlab.com/Linaro/cca-public/tf-a/trusted-firmware-a/-/tree/cca/v13?ref_type=heads
> > [4]. https://gitlab.com/Linaro/cca-public/rmm/-/tree/cca/v14?ref_type=heads
> > [5]. https://gitlab.com/Linaro/cca-public/linux/-/tree/upstream-v2?ref_type=heads 
> > [6]. https://gitlab.com/Linaro/cca-public/build-instructions
> > 
> > RFC v1:
> > https://lists.gnu.org/archive/html/qemu-devel/2026-07/msg02307.html
> > 
> > Changes for V2:
> > - Fixed linux headers to include correct bit shift for Realm VM (Gavin).
> > - Removed obsolete rme-guest options (Markus).
> > - Set ConfidentialGuestSupportClass::kvm_init() to kvm_arm_rme_init() (Gavin).
> > - Got rid of kvm_arm_rme_vm_type() (Gavin).
> > - Used kvm_vm_check_extension() instead of kvm_check_extension() to avoid
> >   error message when starting a Realm (Gavin).
> > - Removed obsolete kvm_arm_rme_init_guest_ram() (Gavin).
> > - Collected A-B and R-B.
