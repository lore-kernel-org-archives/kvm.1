Received: from mail-oa2-f34.google.com (mail-oa2-f34.google.com [74.125.231.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CF5308F39
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 13:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790603065; cv=none; b=o6JmjW51NeyMYnF7GElvPQ65lQA2MaM8Rh6Lh7nq4k2XY0hCjzCqNNAmn4caCm3lSA8JlWbMo1XmRNelee8avBjSLlUuLiTsjKHfG67IWvO7LTHBzbmTCpXl71aGdRTlUc7Mag98MuQbaXBQlvdLjyECVXDgilBT3ErgIxVaplM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790603065; c=relaxed/simple;
	bh=GovrrZN3cHyF7Si62BejyKGqmJUiVqEeTzDNhyu+l7I=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=eu5flDrSwrKdKW1N7RE8MSA56wYF0WJa+xPlIXYyuKpBVWNqi6W8rMOYtxNpCg4dQaTGORDHwakmcMk2ag3rqNsnOyESXx6HPC5dargLReZS50O0pfCudMc83pGUqL/iq6FlaBIdwpXsoJMrQGZfRgcNnTxswC6gP31TXB3pSVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1mrqWpK; arc=none smtp.client-ip=74.125.231.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1mrqWpK"
Received: by mail-oa2-f34.google.com with SMTP id 586e51a60fabf-49499f845edso483012fac.0
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 06:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790603062; x=1791207862; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OqSWB16/v2nKqaGPKDp/hMATqYQmRiJplxi26oO8Rsc=;
        b=I1mrqWpKIyYVHM2mopl6yYRHDwrulVZbbF6uu3h5rKDvIeTItVCmKw5AUiOksIuCfQ
         eFEUqz9ZPvzm1t6cQ/NINZilvbKt8uqX5cHtlvg3qznVv0vk0pXDf7/rxVUap6WzWVx9
         5w1nMpOt2dG8Ms/7S8ssDdYopIlSJRCDyb7XTLK30Fvp+212CsfCzaDDfqKqI5iGR1sz
         HFEf0np+OBbXMTBffRsQoGMqYLs9q7HYQkHQWGT1mwrv2MVkVG7TBtSSkFUzk/6QkMIB
         IguvbvIKZishggAu3DEMhsJ6IZlDBCfCBg4PIqzpbXLYEiXEdsnnW70ZQUy54y+A6/Jh
         9pmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790603062; x=1791207862;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OqSWB16/v2nKqaGPKDp/hMATqYQmRiJplxi26oO8Rsc=;
        b=Q38LqdjJgUNT6b53IQFvBWT/Y9VdGJts1hBt/cYGnE8Ba9gNyTZ188nMxsG4ZfdV7h
         rOq6iRp84akjn7QZQKifEYHoHXbx3VFXHh2fkEIBh0rTl3cHwX+Rzmmd73EzKuf7XI3t
         vtpNXGDnh2lMc6Jic/f6NQvVjSUx/yzfX5wvuSrijByWx4iBJGd59vXnbZUztRTeDYr1
         65Dg4/ajGT19q36qMBHyhC+1oWnXBXzkJlZmektM3+EvP+WM/luhP1AyFtL+EopVlbUn
         IUIgcrrLCu6WknJ13QASPgIBlzhqPzFgIai2YOwXSTiB6kn9b8n6W4KDGqmKY0lTHzZy
         SOMg==
X-Forwarded-Encrypted: i=1; AKwUvBwTAj80z/l2k128CW78qYnJTGh4CmWmQbW8jBmS6548FG1bACiB0P1ombyJHF4RLqc4JBo=@vger.kernel.org
X-Gm-Message-State: AFuF++ngFFL+hbm2HK6kkiFbzqsvlA5fycWD6B3JnsWb5CdV90Qx7FdF
	6kcSq3dKxRXPk7Q7iD9yslMipvr49079PxoIIH7r/aCklAs13Q4TDPEJ
X-Gm-Gg: AYBFou2z2X8cXiU+I8Z3Ct9wnTNNYKAouF4et8T/RMyxWJoCzUsveSYHXdJwlU4YgjJ
	Djug4u7z2RQco5ZdgSmCaWes4Lw2yeQoNHyKyrXpHVP4eveBsNeZZXDM44X9iPKKKutMDLPs6qh
	o04JhpCo9/EbhAsgMSCnZuoTH9BewdelCC1TIa5Wdm53NcHY/s0n77NVcwityy96zxWvTmpEsWQ
	tJAvO/RrDpipOhwspNuv6koPWn9rOZ/YkvizekChVh0xgxMcxiCU2m11/GFpN4OOU1ZD5OuZrM7
	KJhXBKqXpBw5iYbnG7lY6JXq06VULBGWis61Udt7Dbb/brwpcmm7vCLt91uEjHkckzxvbIRxrXW
	GUZTwNTnNeaC92erVYtX6Rv/A9BglsHQ4zuWSWJoigo/9IshNGGauPmy/v/T9JEd7Bt054lCjNY
	Hv2p47v3QV37yt1wJ7E5qZ5FeO3IDM8wsye/fDotEP5YznNw5ifEH/+hlol2v8M66iwruRhQeeZ
	UYv6ZKTDnbDycQEjgOdhUwS2AoI5kiKngFwteOKwgikcJsHUr0ocQ==
X-Received: by 2002:a05:6871:eb03:b0:48f:e0f6:c46a with SMTP id 586e51a60fabf-49358a317cfmr9008681fac.56.1790603062123;
        Mon, 28 Sep 2026 06:44:22 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-493356565b6sm10053356fac.9.2026.09.28.06.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:44:21 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, R Nageswara Sastry <rnsastry@linux.ibm.com>, Alexander Graf <agraf@suse.de>, linux-hardening@vger.kernel.org, stable@vger.kernel.org, Avi Kivity <avi@redhat.com>
Subject: Re: [RESEND PATCH 2/3] KVM: PPC: Book3S HV: Add preempt_disable() around virtual-mode HPTE bit-lock users
In-Reply-To: <20260928122837.8782-3-amachhiw@linux.ibm.com>
Date: Mon, 28 Sep 2026 19:12:53 +0530
Message-ID: <tsn9jxuq.ritesh.list@gmail.com>
References: <20260928122837.8782-1-amachhiw@linux.ibm.com> <20260928122837.8782-3-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> kvmppc_hv_find_lock_hpte() requires virtual-mode callers to run with
> preemption disabled, because it can return with HPTE_V_HVLOCK still held
> until the caller later unlocks the HPTE.  Existing virtual-mode callers
> in book3s_64_mmu_hv.c already follow that rule.
>

That make sense. LGTM. Please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

