Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B14939021B
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 03:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778644674; cv=none; b=KlxeIqk2cE4VYunOyeeVGg+5YwZ9eh8emm0bRs8Wgp9bfcPMdHNYoYVfX0BvZU9DUgECDpE2xatSa8KyZbgw2BSAl3jv0Qr0nF4m4QWDSn9KdGzWr/AT/udLqb22wcq2AUAn48727L2kUCzaTk7ZMM9cnk/6VvagtF34vjlXS/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778644674; c=relaxed/simple;
	bh=4KA02clBr2THgONP7amZfI1GsHfy0Il6SChMfUIqYZ8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=Ntf7279xbb91teMzyC0HbFnQlhAnlmBDcc6x2+1O+3MQ9hTAtEkj4c4SUnU5GcNbyFed6KoozYJBgNXyjELALeewNDnlCEGBsllBSyHfp1nfDMx9FBTpJMH2V/+qxlwt23tbARHpEEkV9Pfv15fSv3nEoctqo14E9PZAyXW1qgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RvgW4Cii; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvgW4Cii"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b9fcf7c91bso63085745ad.0
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 20:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778644673; x=1779249473; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4KA02clBr2THgONP7amZfI1GsHfy0Il6SChMfUIqYZ8=;
        b=RvgW4Ciim1SX220fqVLkpRSWa8F8rGrsVdDVTvVtTFpfAbMUpumV2eDrS2zjiz4u5A
         zYUtwtHfM6Nk83vDDcVcFCqm1BFuKqWY2FC1I3iV2X+5TXcL7Jk+4tnW+P4WTAzEDSOF
         0bNipdM4ZFYlb9odNzAyKQhLQIgtNXCwJCVWFfJKGXVR1hmKELpted0ZvkBphUUS1Q56
         sWmfjGOHGHNgQ81v+jejovN8vpPQ0rWAzPIPD1wd2vGGSvwEcIvgd+zfgULcLdfJ3pCe
         dl1xc4IpgeGH3D6SxPr4KYxPiVb1Cs6492NB4K98jNNlhxjfgcwN2j6wIwfPprIL6/pn
         BZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778644673; x=1779249473;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4KA02clBr2THgONP7amZfI1GsHfy0Il6SChMfUIqYZ8=;
        b=qnRFOLm35N1uF+Wtvt7iIwA/MkEoxZNJ3+rB+3uswrUQhqCKlzc7sYJuZyk4aMAvzg
         1FgJB7DPSYvxrKYSTJFgoXsr2nEuOqrVWFzGlUNb5epJfBtA8MQj/WgwQvDWk4M9uOq8
         uWgst9Jvza+CwCn0fiCPFwc7Q3QB2tuDCYa8xJElC31iFTnllvxns5RsvcztNSN9LO4H
         4TIbDYPRAc333rHG5PCby2W0d8FT+PKLJxVGSzEp/e/sxSxrNIrywzrqOJwF7NimBDer
         Ee6tp5IfoA+zThPAMNAveWh8gns2/rR4uYgeDf1/815Sb3+JCBbrOiczABSthVCS9MW5
         bYuQ==
X-Forwarded-Encrypted: i=1; AFNElJ9jt3U3n1/Wj/Bo9CMYVrjFUPUZob6MPDwNs7zOIt6/Bb73mPK9Q59Cp/2E6lIa+TOqtXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCNZ4iq0WeFwSpGaV1DnubiCod4rhFyZNmGUI1oJtgQfxSH6uc
	XM0I4utNOid5fYF7t5OaNdxCn68ipl0+H/8OE9TYX5rnRo4XO3PaRi+v
X-Gm-Gg: Acq92OG1X7UCf/0sVDZXpWWt5rwmNmEDUFqHkPUFup1VdWAiH5dVO7iA/GdxIlV7ukl
	3Q3/NUiG5k3aoUqkP9wDnI2UT43uB2N2MbA2aR9OyqA6svGTHTqVpXZgti34ewLvIKzEI0t4LM0
	JtRb8M0Reg1f7K8XLq7Tx0ChtUn6ZzEhTiWEhY+8KT78Y/Fe6kwhDirubzx/LqUMeqZZr07atDh
	2UjznAnpmxL06kC/HlrtmstAxN3KmsILMO8VFeufrQh9sje0SmO4phc4if9lAZHakkuZdV+Ivxb
	EGzXJ9Nea4dGUmuwJSlYKaNFRG5KkGMp9ypnvKEizFoi1YG6wSlkOV8JxUqgSn2t0YrKtNV5PkH
	Rv0X2MMP7ba4yBpovGSZh7IwslhC3k7GgvaxSaGoKSGAdSeSDadNNypYnWzEHmovF/Y76CjihK+
	3Psqw1Bc7PEu/MSz8r828raFE8VPFxy5VD
X-Received: by 2002:a17:902:ea12:b0:2ba:6ca2:bca with SMTP id d9443c01a7336-2bd302267e1mr11964095ad.26.1778644672563;
        Tue, 12 May 2026 20:57:52 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1eac6bcsm143075685ad.70.2026.05.12.20.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 20:57:51 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gautam Menghani <gautam@linux.ibm.com>, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Amit Machhiwal <amachhiw@linux.ibm.com>, "Vaibhav Jain (IBM)" <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v3]  KVM: PPC: Book3S HV: Add missing mappings for tracing exits
In-Reply-To: <20260512115724.59299-1-gautam@linux.ibm.com>
Date: Wed, 13 May 2026 09:22:26 +0530
Message-ID: <tsscq83p.ritesh.list@gmail.com>
References: <20260512115724.59299-1-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Gautam Menghani <gautam@linux.ibm.com> writes:

> The macro kvm_trace_symbol_exit is used for providing the mappings
> for the trap vectors and their names. Add mappings for H_FAC_UNAVAIL and
> RETURN_TO_HOST so that trap reasons are displayed as string instead of
> vector numbers when using the kvm_guest_exit tracepoint.
>

LGTM. Please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Minor nit: It's generally simpler for everyone to keep the related
patches belonging to a common maintainer tree in one series. For
example, we could have grouped patch [1] with the current patch into one
series to keep them together.

[1]: https://lore.kernel.org/linuxppc-dev/20260511080412.50722-1-Gautam.Menghani@ibm.com/

-ritesh
