Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2472236E48E
	for <kvm@vger.kernel.org>; Sun, 22 Mar 2026 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774195066; cv=pass; b=pSLmHercFCAj0/+M646ZLSL8b5ObNf4O2K+MXwSnUpXZmIxPLskqBkPvzRg1Ee0z0ctxZrXI88zQM3hlMDqRBgmolBCrNH85KwMMqUA7t+MtPAWDeo6STGM9cewqe+dAVWNzaiqR/hJbRf7j/VmmPwlbxoHUF8Qo7wXY/T/OaZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774195066; c=relaxed/simple;
	bh=65twC/jhEDZiz0eFQDVmydTjZYj0s+Vqfpys2qBneXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kD80uD20FoOVWMfC7qqyUsayxS/H7qDGMla9pfvRXbWJdFk1XKNelB0mhWbR6MCfcRrevKRef3pqwu1A5tm39mRI0VcjwRzfDqsZNI1dxVbAzC+0CqS3zN0BNodE0Y5nnbo1gkIX2bQoFIHrVTmlPz2WSG3+agOPqyZTGMsVR9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HGpgkux2; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HGpgkux2"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50b30d61be6so935101cf.0
        for <kvm@vger.kernel.org>; Sun, 22 Mar 2026 08:57:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774195063; cv=none;
        d=google.com; s=arc-20240605;
        b=f0UKno4KBkiAmaCztxUyfdXUk5cjUv+8onaCGXbCqMPiUefUYbaF/nPlAmaKiYzPMb
         lDHJ+fOsgPtZBpe0e4Te/YU7xRpCz0kv1pzRo+yUVc4KxzRd8Ur4Y1V5Cy46pI7KL6SR
         vdbzjuYkXZZIP2/9Bdg4q7i6h1F4TU/0xw5TCsvWfsOdYVOqFWPXNF7MzcxpcAnSbipr
         tfT8ijcyZ4R0h9NoEiWivdvFAfFg/E3ws+A7K4qbSQ+wXAIes5SZWxjkp2mF885fHiRY
         i97fiAtOvVMKDq0sG6rHp60RkbEUw4ZZQT2f+8LGmtK4Woi9duNlfoIoy/GNPJbF+lfh
         fVGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jruzd6NkqjuAAF2rHJBm3v3faoRwpO4fCUwyZnfsofw=;
        fh=6g24h/0rBQa3VRkq7EjK4GxRWzZDBfTvVytLhJXBKC0=;
        b=MIYoRFpTeZGDpVWaFlhtguFvOaNSHthaPkgdK5odb1lCPVPnPPo1NoOnW4rxDCoyJZ
         xZrcGmB/ctmZ38e+SDJ6gZUUJlUXAOT6537pQugyaWNg6/+CP1d390KKNcDqFLzStbSa
         nq+w55UKrwbceGgBH/PCOS97SMGM8wC3gu0BHq3iOWPGpQt0luQNfZo3sTZOTFNepeg7
         Pslt2aEXNT7r9HqN5MfAhNua7TKuAOGeuOv1WLHFZQk6b9IE5xO9LZPDUvxG963uUiIK
         nmPihlXrdW37ny/nO0kw9oghb6xcM9M177KZ9yQcPV0cBvynKMTI/bkt/e+Noh42HyGV
         MMfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774195063; x=1774799863; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jruzd6NkqjuAAF2rHJBm3v3faoRwpO4fCUwyZnfsofw=;
        b=HGpgkux2ZGunrtxm3MmbjBxBykIEMWfSHHlub8AlnVwaIjAxKjEwS/34qclxehwCLH
         WeYCoACRlXzlyZV4OF+HrS7k2xvGkg0DAyBwZSWszUblDP0Hmh0XmdO0k/bVHAEtFfk5
         DynA3J6RrpnAXo5hzUY+mnyMct5ohGeXD6FCpYSgMYRHdrfGOV7/CWbOCnrgll54ldTP
         /EB98fDMTuGqM9JWNYqcO+Wb3J/XhtQug9p4xrmsBbO7fUIIvpJrzQRrSn+WzNLMqF4f
         VkNf6Hi85llL5aLfxJHCoLt13OyqfSdrTzxBwmsfgQmT04TXTABS1u46SkcmImsVK86Z
         TfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774195063; x=1774799863;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jruzd6NkqjuAAF2rHJBm3v3faoRwpO4fCUwyZnfsofw=;
        b=W5vuHpO7n+XEvsAyvrwtyUKntLzJ8bfKo/frLC+nJhBr+V1SXR3w9Tve1/jAR658od
         a+MdXO2Sfak0zRlNW9FNxsayErCu7wX92Q/rXNTnl1+pbACTHPtaLKxOojxD8NYJbDWX
         PbzZ5P1CWZdWdx76StJheCl06+jLGddSlPWthaPUCQzeh2PGhD3vQSF50vizGiD3C4IB
         bobGJVTE+XQFXq8tFeA33TOMhPla8xSURaEoA5yccdvXpo44SQJxd5F3NzR7rK1kNDi9
         khfRi9fS22zVqZc2qh61K8mb+F36MCvCUODPLoD+lNQdTzqfmzo11/B0tjLsBpeGSGIY
         MYYA==
X-Forwarded-Encrypted: i=1; AJvYcCWfyz0QTmbo2WfcOWTuR2VarfDiY5rDH8uw0aqCxEA/sjy/mIswsI5Mv+MZt4Lt5OMFCys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhIIbOHjRChyb6CnsIbpfCRCZZOoJlLl8GQZwz8rSJ1bfn37Cx
	Kk0P35qrLVq9nQVbGwZba8DMaQ43zysNFmN8aC6W8mZ13K4vu6AnncM/jWJjKsmFmIT+qo6yC/z
	zh6nwkDXbDZ5m4rnFqGJ/2xWpcVHEh20bnUL1qLSR
X-Gm-Gg: ATEYQzzn7RhHHQHUTDIRoqkj4IH5P5gO6DluMf456CFxYID6WUGtN5eczGFURxesnjf
	Tg/NMDKJQQxUXtYlkhs3CrkmuX6Cepv+LYljhZKkXjaaTvRApi90V3veFPRmmHNkw0ZvgsbqaOb
	d0z3L3twFEIDTOjWkuRKQPnSR33dF2lpqH67cka1Kx7mmBZBr3SidqyskuTmrWjiaYjtxAmSYaP
	hzgyKSjEenZvU4XTbbxCTXMHRPwp9RQIMJuhCuZ6fXYUpMuQmV+1o6e0VYwxwWp66WhpPWOpB09
	T6wmmKeo
X-Received: by 2002:a05:622a:1211:b0:4ed:ff77:1a85 with SMTP id
 d75a77b69052e-50b480dbd8emr16496101cf.17.1774195062641; Sun, 22 Mar 2026
 08:57:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321212419.2803972-1-maz@kernel.org>
In-Reply-To: <20260321212419.2803972-1-maz@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Sun, 22 Mar 2026 15:57:05 +0000
X-Gm-Features: AQROBzAJIzRJ8D-goNBVthnfORrFTafE31L7zl763iq-2MUJoVzQZfSh1NnQFOg
Message-ID: <CA+EHjTyqYQhCCYCRyZv5Purm1_2gL6KGeq_Y24sgiSZgWuGT1Q@mail.gmail.com>
Subject: Re: [PATCH 0/5] KVM: arm64: pkvm; Rework aspects of the PSCI relay
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Oliver Upton <oupton@kernel.org>, 
	Zenghui Yu <yuzenghui@huawei.com>, Will Deacon <will@kernel.org>, 
	Mostafa Saleh <smostafa@google.com>, Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 21 Mar 2026 at 21:24, Marc Zyngier <maz@kernel.org> wrote:
>
> Having recently spent some quality time debugging [1], I ended up
> reading too much of the PSCI relay code and felt that it could do with
> a bit of spring cleaning.
>
> To be clear, this series doesn't really fix anything. It simply adjust
> things to my own taste, which may or may not be everyone's.
>
> Comments appreciated,

With the copy-pasta fix to patch 4:

Tested-by: Fuad Tabba <tabba@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

>
> Marc Zyngier (5):
>   KVM: arm64: pkvm: Move error handling to the end of kvm_hyp_cpu_entry
>   KVM: arm64: pkvm: Simplify BTI handling on CPU boot
>   KVM: arm64: pkvm: Turn __kvm_hyp_init_cpu into an inner label
>   KVM: arm64: pkvm: Use direct function pointers for cpu_{on,resume}
>   KVM: arm64: Remove extra ISBs when using msr_hcr_el2
>
>  arch/arm64/include/asm/el2_setup.h   |  2 --
>  arch/arm64/include/asm/kvm_asm.h     |  3 +-
>  arch/arm64/include/asm/sysreg.h      |  6 ++--
>  arch/arm64/kernel/hyp-stub.S         |  1 -
>  arch/arm64/kvm/hyp/nvhe/host.S       | 11 --------
>  arch/arm64/kvm/hyp/nvhe/hyp-init.S   | 41 ++++++++++------------------
>  arch/arm64/kvm/hyp/nvhe/psci-relay.c | 39 ++++++++++++++++----------
>  7 files changed, 43 insertions(+), 60 deletions(-)
>
> --
> 2.47.3
>
