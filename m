Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501893;
	b=G4lYhTr/kB/jFY7HGl8PP7FKuTEFcihAbLsoMZ1qBH/KlsZJ+r7WhTX6N+SOCOe8bIKA
	 4hFdZjwxOh1u+XH0PQZgxwzmmZqxcoP07Cv2b51LRTbBWlnnWguUwpWi2FGBfDGAwoABJ
	 1movhFxqj7atOc0dHAGRgap5Mofni6iuNzc26ZbJnJnKru/6oSkrNvmWVD/MSMRX5bYha
	 o2QamycXVRyYduvX6766wasC6fUGFX7QjfOLusPnGXVBGomXYoDjaLrnZ29PfNj+tp5tn
	 2MHat4D0QYCf9wC/uyULjqEQvL01T72z5bu0fMR9kU2klAytNE42Fzbfb07t1zrgtuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501893;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=N/JJjQAxr7gs5XtFIopHR9Vrbslfj/S3BZMOowPnB6o=;
	b=KrKSahJj3Efo4ln9VIhlUMYo/VQP2SXd4wT+L/1fKVCxcGHuWql1tX/PuZjzqVdZTsZC
	 C15bKcqZntHIVhdPB8MwSGRcvZXhJttuDb8U1HlqVTeIko704NFOnLV3ulXvc01IUMybz
	 aRdYytqmo0EB1uycJupsqmn16QPKtodGU3Dpn9FHPA9o5QYFYBBBv/9Xd7t3FEG8/YoWK
	 Yv7GsEXVg/7aL1axpsvzbByT+fj6xxN+JPu9GSnQptnjWT2LS5fAp+UgcyuJnTNrPDTvA
	 cV6BUj31BF8LKaOFrndxanNQyDqLfy5VA8og3sIiY1zmRfDcsBHQxkZCGTKHeMx5GBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KgyDMV55;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AC4606A898
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 16:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89AC4606A898
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KgyDMV55
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ed2803f863so386885ad.1
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 08:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794501893; x=1795106693; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N/JJjQAxr7gs5XtFIopHR9Vrbslfj/S3BZMOowPnB6o=;
        b=KgyDMV55dgAMB96NH6xPoULExcKQ6F7+p4ffGn/u7ogvRLZG+3wGkwPVFeKSaOqkhY
         31+ZGnNQ4yJIf1ndpeldECdolpnZwx2LYh43xsuwgubZFVizoY5374paI3PJrlqbpERh
         YmqPkPPnin0+XMmH2X45vR7l2BgtpR0cMVRTX+TP5H5kQf2ZqOIaGs7Ov1hG1RlyfmT7
         TnaKb4/53FLAKn8iHG73Qpgre8lp5oFkVH7cU7GAyux0eEjEoTnDFdvS3FkklSMsJwWe
         cNz7+jXpomogS+CvqfViehQpNSdFumH1prz1lE6EnnLhQGhThZ+CkmtM1IQ3GmOBkn/o
         0RMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794501893; x=1795106693;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N/JJjQAxr7gs5XtFIopHR9Vrbslfj/S3BZMOowPnB6o=;
        b=nxnTSUdcAQevYGFklDciSs+In8Nv9SAs7b8SXzCI6w6Cr6TmyBtEe/n/D8Qzbxvwcf
         UOkfjjab12bXl2CiZvUMNyGGidb3+zsMSyXmh7kzL5GGYq12JaVdcUIospzkl26aTpm3
         TVXZKRPqGbgswx3/MQ5oCOXxz/IEidQcxZpwz6X1xDiAuviAqy/tPGf+z5qwgQyX8LNX
         zSwvyWJJ/zfRxfyYZqMpL43epnBwo9H5TnhKHEtd5uHINBvDMBvYzbGlSdK1+eueiwyU
         vaU4eSqNrqcLkgMgUdQTl+/imf55kv1ZMMoJUTHej1BD0z/otk9lxEnOpzvY6mH1w1zC
         uZ0w==
X-Forwarded-Encrypted: i=1; AL+hErHus2NgVRubJ5Saq9gDV9R8PoVx+P6er9TUsF/08hjJS4xKIUA+MJOEvijZvw0Ejy5AbI4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/FSPL9JEd0gzsXRGkSyD5BvcPJ1NHBI6lbrP4WDtqcoxsRRqbz
	G2HWzp6szkiRvn+a4pLr3G0gEKX6DGygTBDtsSZwF0dNfDKMYMLf8MWbBqRhIwxYbHuT/fBSU2F
	VRPnmtw==
X-Received: from plhz2.prod.google.com ([2002:a17:902:d9c2:b0:2ea:c4fd:59fb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d481:b0:2e9:87a2:b4f8
 with SMTP id d9443c01a7336-2edd775c023mr63208465ad.29.1794501892291; Thu, 12
 Nov 2026 08:44:52 -0800 (PST)
Date: Thu, 12 Nov 2026 08:44:50 -0800
In-Reply-To: <avWnci8x0fn_4ck-@stanley.mountain>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <57324d544da1e92cf3b30ff7c40595dfbca1933d.1794465097.git.priyankamani2100@gmail.com>
 <avWnci8x0fn_4ck-@stanley.mountain>
Message-ID: <avXtAsi3Llq6Ua1n@google.com>
Subject: Re: [PATCH] KVM: nSVM: Check full nested state size before writing to
 user buffer
From: Sean Christopherson <seanjc@google.com>
To: Dan Carpenter <dan@pereq.eu>
Cc: Priyanka Mani <priyankamani2100@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 12, 2026, Dan Carpenter wrote:
> On Thu, Nov 12, 2026 at 06:41:43AM +0000, Priyanka Mani wrote:
> > svm_get_nested_state() compares the userspace-provided buffer size against
> > kvm_state.size before adding KVM_STATE_NESTED_SVM_VMCB_SIZE for a vCPU that
> > is in guest mode.  When L2 is active and userspace passes a size that is
> > large enough for the header but too small for the vmcb12 payload, KVM thus
> > skips the early exit, copies out the header, clears and fills the full 4KiB
> > vmcb12 area past the end of the buffer described by userspace, and only
> > then does the caller notice that the returned size is larger than the
> > provided one and fail with -E2BIG.
> > 
> > As a result, KVM writes up to 4KiB beyond the buffer userspace said it
> > has, and if that memory isn't mapped, the ioctl fails with -EFAULT instead
> > of the documented -E2BIG without reporting the required size.
> > 
> > Compute the full size before the check, as vmx_get_nested_state() does, so
> > that a too-small buffer is rejected without writing anything to it.
> 
> I would prefer to instead move the if (user_data_size < kvm_state.size)
> check until right before the copy_to_user().  It's more future proof
> that way.

+1

Side topic, your mail got flagged by gmail with:

  This message isn't authenticated and the sender can't be verified.
