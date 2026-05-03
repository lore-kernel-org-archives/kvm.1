Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184222D877A
	for <kvm@vger.kernel.org>; Sun,  3 May 2026 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777827443; cv=pass; b=j71TEvfVUh+q68Htdj5fE+Tyt9XByN996sWnoMDTpAfE1ZGe8pneJBV8LU1H8LR+n2xgWWPaWBbWoAOQ20CFnNi+i0495A/rx+KttNn+6DLlGHIN+RKhhrdLFIQj18nHJs/G9bnyaEczhdQ6flzesaWdm8xEnJGtPIurFqoFf9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777827443; c=relaxed/simple;
	bh=dxYvE74iVdKlUnabVeaymaom4WUqjZShmtH2aclRsVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tPxlC5raeJRcQ8QeVJ7h2shsLMTtrTHaHzR0RiqzPXirtcgH2nUo/dPoTmAmpshCfdT/jm3TXG1/LAE4VqecGrGa1Tzslk6O9NiE6if9lKcNr8mO9/CcVwq9qwjoPrjiSyormmpvU0E15Nf1TGOc3/SgV9dn5HfEKZyOVN52rzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DgUfCvRV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=K6y3Fsoe; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DgUfCvRV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="K6y3Fsoe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777827441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wZAX/3Dxul6ab0aa4nY+5/E1aKies+ngH//pLM2CQH8=;
	b=DgUfCvRVnxqbOwpakxKF6tkY2CQCl5LSrOYg3BKffb1zF3rHOxb3n4Rkf7ThWj0/HPoX9x
	5oWAn93vUTr+GtmbLuhv7/AbAkoRLsFfavsttC28WzGuzfsTA4SwVhv3SZJUVhyOd+qc/6
	/jPKgfSlW1067y3dyVV6lQw1Pw8E0Bs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-7zE3gLTHPFq2iNy0jUhfpg-1; Sun, 03 May 2026 12:57:20 -0400
X-MC-Unique: 7zE3gLTHPFq2iNy0jUhfpg-1
X-Mimecast-MFC-AGG-ID: 7zE3gLTHPFq2iNy0jUhfpg_1777827439
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4837bfcfe0dso38442175e9.1
        for <kvm@vger.kernel.org>; Sun, 03 May 2026 09:57:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777827439; cv=none;
        d=google.com; s=arc-20240605;
        b=O/r9wehTCTqplJrqt0D8H6klnBheqbYqq/xySImZiVpL+TBQ2dOQeT3tNg+ltoUe6M
         g+HM0jnle5Q5dBaV2NXeklVSn2oS+ZAL++O6zxyk3DHMF8SCYjPjrZh8Jtt6/5uQAALO
         +fDbkE/4j7li5sWmbMngoogh5GvX8zvmDyZmNsPTi0FrAvI6uMyj+7kANmtoR/Vvi4xJ
         Czh6h085CUiSiMfcylWVSbke0XjCHl+2qfKFYFfFW7skS5ugECRNO92vrTwoGNIXyVkv
         vG3irQmlmCo59jfHqaIHs2fnv5eqPs7KWEl+mwlccMnVPoPr7YMqjn1OUNg0GQ4hdAPR
         ag2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wZAX/3Dxul6ab0aa4nY+5/E1aKies+ngH//pLM2CQH8=;
        fh=oeFB5ff+uCKIvzE12eowaUKmoY89q3O1c+j07HMUsSs=;
        b=lwkxAB2lf28+x0h/QX4J03/UH6zkP0fd8Fdd2Lg/72AN4CLfvuUh5t20Gw3mYh2DWN
         1MpQ/XbETqnQcOhlgMdLVDASADgD0VEm+6xTnn82Be8YaysrSGVa4YB4/po4+7fwS25X
         13l+vthVM1F0ghfglb/aE/0E2WzPHtyUwCZkawSTjlfg2wu8KVlzv9zOmcYGbof37ggP
         OMrwZKqbFVa8YogkAE+gi/WNwtW16Zs5Ylt8xjVXmnzOyoyW/fz9X0pIfrx7iw6+zXuW
         K9E8Qg+9VyekI2kj7o3DJFIpL4bjnTaM9DXHv0qy4KJHrqINhENA6uLLoqs5GWEWWVR/
         m8og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777827439; x=1778432239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZAX/3Dxul6ab0aa4nY+5/E1aKies+ngH//pLM2CQH8=;
        b=K6y3Fsoej6/SlnQNS0bDt/XrAVquTsfmruWXqQF6HVREFuFAmJhpJeXRKsI8iA8Cml
         8XjrglhkaqvQy+2weOQGdhaFmoapg82agqAsHXozvAEUZWXrbxBFzd098+n+vzfMEgae
         t5/r7p7zGRgKW+jPfyuq0lvgbUHr+N9iIgNx768UxT5EWoZCBTHaBfTkfMhz3yp+Bdaz
         nnF4gPxxsWQ7Wp26+z9d28DtrLP7arK/ly2gdeSmg0PfhNDRKh231K4fgNqjE5gocBXc
         n2+DhDcFsjLmk3AkiChgkEIQbnBc+x+iIFrsYtTnMH6r7Kn8kB4DboJsZO11K+IV8fGc
         pzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777827439; x=1778432239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wZAX/3Dxul6ab0aa4nY+5/E1aKies+ngH//pLM2CQH8=;
        b=K1TxzuOeHjas1p1m9ri9XX3sojYOSSMIkwevxIXBfJK3l+WYGnEAdF9BdDbG37j9YQ
         lLrqfHDZ5vYy1hLQZBgt/bQkKuF7IdXePlkAbCeoLfcP0SvYM2+ZDYqG+s/OOoSEij+0
         tgh6pSabpTOHWU14GU4FTlDpiUK3uB1J9TEd6xXrwox2tG3GGL0rpT/sb4w6IcjcXama
         qQlftp+sYOJw0LqMx+9LbNjTfnDo2NEw7GvEmhXq+VAqlq8Jsjku8u9WNdiM/xjiThN/
         RIboGP303kYya/akSWubXoBIvsxOUIW9Qeh6HiYP/Ajh+IGeE33EuZj3kASW7qZbKN5O
         2unQ==
X-Forwarded-Encrypted: i=1; AFNElJ9pmsytvsFNaUnRBsbJMEPYO4N7xg9mQacueY0osxmC7P1GVRcS81Qfjoymnlo3Uv6y7RA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPoU5dAyrzq6XrzPPVFeqT8XRIngTz42/3spFWamICvWShpj8E
	bhoYwyBma3YaqsZooShyoQ8hXX8NP7MBR4nbWulcT3K2afNWPrqTG3KJuU9fCKaJmbkimhkZ/XK
	n3NgtPXuEbqZswoEr/YFUB+jwCqO6IIKU7F0XS6pvsvdK4oUJn26lZP6AGaNUMnz+DYKLX+6369
	n2+JTL8fk+YC38WJwRGDFx7P5j+KHa
X-Gm-Gg: AeBDietSHtaZiRBP7NCbt9c1VzKZUz6v1yztvC9NxqVRmteD2WfuRoaQrQF+u2jQZff
	s7tLkA43BpGQxGZ/ob0mu2T04X4ldpLKLUqDG/AXXObH+aLjNAcceSkgbVL4aGOZUddW4DV2MPL
	oYudo53/VIFP7Epc/Jn1obyWMB2Lxeo4o050nF/m13346Zy1xKiMZ5WxCpzh8IhMmqXM55yvikY
	Frv7AgT7c1FA405uJyDbYi81tmaX93urwp9ljT2qTAAfN8uzMxhMSgEo4KJ5GOMSlO5bTVoVTjm
	7JbrH9JeLpUY19U=
X-Received: by 2002:a05:600c:c0c5:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-48a98662e71mr84651515e9.21.1777827438728;
        Sun, 03 May 2026 09:57:18 -0700 (PDT)
X-Received: by 2002:a05:600c:c0c5:b0:485:30d4:6b9e with SMTP id
 5b1f17b1804b1-48a98662e71mr84651295e9.21.1777827438361; Sun, 03 May 2026
 09:57:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <afEwWZksU0Fw61oT@plex> <0a71472c-b397-4699-a518-61faffcf4ab2@redhat.com>
 <afUNlL_lRDP6olHE@plex>
In-Reply-To: <afUNlL_lRDP6olHE@plex>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 3 May 2026 18:57:06 +0200
X-Gm-Features: AVHnY4LZ9SLOVvMSSNVqrWN2ReqSfwRcQuKsaciqQRZIlDN_XSMAX0q55GthIJg
Message-ID: <CABgObfaqZ8GGaLV_gp8o+nQSe+JfnBbZP0X9cDxdvEpyUZQRnQ@mail.gmail.com>
Subject: Re: [RFC] proposal: KVM: Orphaned VMs: The Caretaker approach for
 Live Update
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	kvm@vger.kernel.org, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	rppt@kernel.org, graf@amazon.com, pratyush@kernel.org, seanjc@google.com, 
	maz@kernel.org, oupton@kernel.org, dwmw2@infradead.org, 
	alex.williamson@redhat.com, kevin.tian@intel.com, rientjes@google.com, 
	Tycho.Andersen@amd.com, anthony.yznaga@oracle.com, baolu.lu@linux.intel.com, 
	david@kernel.org, dmatlack@google.com, mheyne@amazon.de, jgowans@amazon.com, 
	jgg@nvidia.com, pankaj.gupta.linux@gmail.com, kpraveen.lkml@gmail.com, 
	vipinsh@google.com, vannapurve@google.com, corbet@lwn.net, 
	loeser@linux.microsoft.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	roman.gushchin@linux.dev, akpm@linux-foundation.org, pjt@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 1, 2026 at 11:48=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
> The way I see it, vmfd and vcpufd need to support LUO preservation by
> implementing the liveupdate_file_ops callbacks (.preserve, .restore).
>
> When userspace preserves the vcpufd, the kernel isolates the assigned
> pCPU (probably requiring the vCPU to be pinned to the CPU, and the CPU
> to be in an isolated cpuset),

Generally speaking vCPUs do not care if they are pinned. Do we need a
preparatory ioctl for this on the vcpufd side, even just a
KVM_ENABLE_CAP or a new bit for
KVM_ENABLE_CAP(KVM_CAP_X86_DISABLE_EXITS)?  If
LIVEUPDATE_SESSION_PRESERVE_FD suddenly can start offlining pCPUs,
that would require a capability check.

> Even for this simplest form, we still need a defined ABI between the
> host kernel and the Caretaker. The host must send an IPI to
> synchronously notify the Caretaker of attach and detach transitions.

Yes, but it's unlikely to need stability unlike the KHO serialization.

> This ABI must also handle Caretaker replacement during the adoption
> phase: when the new kernel retrieves the vCPU, it requires a protocol to
> notify the running Caretaker that the pCPU is being onlined. The
> Caretaker must reach a known, state at that moment so the kernel can
> seamlessly replace the previous kernel's Caretaker version with the
> current one. Finally, the Caretaker still relies on the CCB to access
> KVM routing pointers for forwarding VM exits back to the host during
> normal operation.

I'm not sure if routing pointers are needed, as opposed to just a
call/ret (ignoring detachment and reattachment which are different
anyway). In the end, the x86 caretaker is basically the
non-preemptable part of vcpu_enter_guest(). Even once you add
attach/detach, the body of code that runs in the caretaker is roughly
the same and what changes is setting up the address space, the IDT,
etc.

> > This must be done atomically at the time Linux offlines/onlines a pCPU.=
 The
> > interface from Linux to the caretaker must use some kind of IPI so that=
 the
> > new kernel can force a VMEXIT (if needed) in the caretaker, ask it to
> > serialize the vm state, and pass it down to the new kernel's caretaker.
>
> Yes, agree.

BTW, the same IPI is needed to force a VMEXIT even before kexec, if
the old kernel does anything that breaks the running VM such as
madvise(MADV_FREE).  Should not happen with properly behaving
userspace, but it must be accounted for.

> During the kexec gap (when the host kernel is completely offline), the
> Caretaker acts purely as a producer, writing trace events directly to
> this physical memory block and advancing the ring buffer pointers.
>
> When the new kernel boots and re-adopts the orphaned vCPU, it retrieves
> this memory from KHO and attaches it back to the tracing subsystem.

Yes, this should work with remote trace buffers.

> I agree regarding HLT: during the gap, the simplest approach is to just
> skip the exit and return directly to the VM without attempting to handle
> it.

Or even disable intercepts for HLT/PAUSE/MONITOR/MWAIT.

> I completely agree that the transition into and out of the gap must be
> synchronous. As discussed above, using an IPI is the right approach. For
> entry, the host kernel signals the Caretaker via IPI to ensure it
> reaches a known state before the pCPU is offlined.

And then does INIT/SIPI on the offlined pCPU to re-enter the caretaker
in detached mode.

> For exit, the new
> kernel sends an IPI to the orphaned pCPU to force a VM exit, allowing
> the new kernel to take control, update the Caretaker environment,
> and complete the reattachment.

> > Yeah, I think APIC emulation to some extent must be moved into the VMX/=
SVM
> > fastpaths.  The good news is that this can be done already as a PoC wit=
hout
> > needing the whole caretaker and LUO infrastructure.
>
> Moving APIC emulation into the VMX/SVM fastpaths makes sense as a
> standalone effort.

Yup, that's nice to have.

Thanks for the detailed reply, I limited mine to where I wanted your
input as the author of LUO - especially with respect to privilege
separation.

Paolo

