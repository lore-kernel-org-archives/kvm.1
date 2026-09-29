Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C386258EE9
	for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 01:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790646664; cv=none; b=kNWDzl7gE0+MEfr5KirkNCqQkMaJAmhZcmJ1/fGLhEqvKUGNw4h0qRfOErxhLYnJL/Z80HyMBaV49iAD3iPkpBOe2Z9dp0D1etId9rD57ZtZPLY+HohdZZBT1paPoApWJNgRZ43y0Ya6EqxpChlqmIC8ybIn1SYCCnIHpV768zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790646664; c=relaxed/simple;
	bh=defNTj3mi7sHrxVRjwLhgcyKIEsYh8Z0QM3DyUvlMZY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=nbqYZEzOCkTiX7qdxnXlufLPGPvVRX7aSqC2Z8Nh8RRpGgX+JgZg81q4H6h7H9vO/1WT+oiNyDcH6xJODrHmcy79rjGQGSLc0heW7CYhs/KDfLXVAw+iz0a6I/8wFvleIwTWIwtw9ePA1xpr3PLsgJWLh2+H015egwq2rNqh4q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYdfRjVX; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYdfRjVX"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33bfb26865fso3760852eec.2
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 18:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790646663; x=1791251463; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=defNTj3mi7sHrxVRjwLhgcyKIEsYh8Z0QM3DyUvlMZY=;
        b=RYdfRjVXpbTw7L3wRhICKCh3QlSOKHvAesv7oywwmYrHWcuKwR6xfkTXQweTCEjTRT
         hnw/rtGvr6B4n5kJTrxxbBCfvawyx35lbblf+IcOlH+0rgJOtSULDPfOQBWW9Y0vIeOS
         POIqN8cCIdvaT7Avv9bQSrcKC7mj1OuF1QHbkwFp5Z4zbIFBU+/Bzo4oE4xYFqlsnhTQ
         FilGgaxCm3kXMjlX9rarE/3/ZSErZcvcsBY5YXKjWVMoZiSys1kM132ny4UPGb8iqKFU
         YNWB2eHjVfWCms4RvJef4/xVIGNc1lEGkmFbPG5mabLi52feZDTQ1Uq66ErfC7pu5V60
         ugQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790646663; x=1791251463;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=defNTj3mi7sHrxVRjwLhgcyKIEsYh8Z0QM3DyUvlMZY=;
        b=TPXrMZX0510AB8aKNEBrSLeJVYkpFWebjuW8FgEi0S8RY+sIMK0Zf/XBP/VKUmCNZo
         oCHbV7qUeJKgu5an+RUiwbprQGhvPJbmlY3CX8BO2Nlexbs5pOJayIxaJojg3cmDwROE
         YtGG1wFK1KeAanafSrxJjBTMj77izxD+GeZ3MkdFb3hKAsd4krcYBs+BWnrhe4zip34k
         NLJ7bST9OtOPyy2vxqpujoROH7SUympGXbMbFDvcuLJxR1/6HFgYTVVv4SFILieX6yE5
         CeuwUEYNrdmLiRBc9+QBMEXY9R2Sq8sYu6tgSN62vZ1W3uDlSjNBFdy7qUiN5iaoXznt
         ko7A==
X-Gm-Message-State: AFq9FYJkMw+sqDkZWkhi8SaFp+UcBH6x9UAg0GDGbdxbuTKf5YZlYaR/
	9tjOB5WMLlFSetfIPxF8o83124mCACUqudyGIjRoFjL57RwqNQJGtDdy
X-Gm-Gg: AYBFou24H9rHNNODehl+8S/7ccWqCuX6mIbOorjlpdM/Fzg79pTixRME61PY6xySfL5
	yCxSRoqS1mzks0yE+baebvvxM83hsvvgmOj3UO/ZTnpQTCoINDmczkyhA7je41NXIG8zjSexLLS
	nOiAp9mePi5QJegip25ZCfJRnyCkvcs7KN/DOtm6E7dXodLrMON9Uvzjz3a7GinMIe7yoOGJsin
	IgE8gwl5UB7BtpTCibRaFc07+rGph4+nyBDd4yELTpjo+nMtBjEYzk8+TfzOfRnUlp63Sz12Gi7
	ttPDCkV+uKul1yGtK1tRLFN+GToFE2IfXbB9Y55ZmAbmylALaMfHtVlYX3kGIPLGHqguCaI9wri
	ipNsxu+QXz3ini1RO/8yRvKHSQHci/a7TomKpVGGYwNDj91SJlnDmHq5r0RSQ0F65TOY+XhAFTe
	neaiQBr14idns4ik1URknOuA4LlgPnJKfkrkBCKcXOhPxtKxeKgH+PVkDergZn4aTMUC4tuXadj
	WVmsEGMfogO4Vmwhw4m6+wbfhIbkbQOHOloXECR6GRayiA40/OPSqbxsGqdh9l4dw==
X-Received: by 2002:a05:7300:ed06:b0:33c:e61:e1e5 with SMTP id 5a478bee46e88-34739c07e6dmr8293196eec.21.1790646662193;
        Mon, 28 Sep 2026 18:51:02 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-341f2b18cbfsm29834837eec.30.2026.09.28.18.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 18:51:01 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/9] KVM: selftests: add powerpc support
In-Reply-To: <cover.1790101179.git.ritesh.list@gmail.com>
Date: Tue, 29 Sep 2026 07:05:35 +0530
Message-ID: <pkxwkffc.ritesh.list@gmail.com>
References: <cover.1790101179.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

"Ritesh Harjani (IBM)" <ritesh.list@gmail.com> writes:

> Hi All,
>
> This series primarly adds KVM selftests support for powerpc (64-bit, BookS,
> radix MMU).
>

Hello Sean,

Just wanted to check what's our plan on this one? Are we planning for
both PPC pre-enablement series of yours and this one to be taken for
v7.4 merge? Do you think this can go in too?

Thanks for your help!

-ritesh
