Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FFE51FCA7
	for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 20:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924196; cv=pass; b=T64etRA2jw8+uwEwqXLciENc8kBBl0j/seJrorznLhNn6rSD+Euf28Zxupxl2BOJ8yDLTG3KNc4eDTDtrtxKyne++g4LtdrH8MGa68Numa80Isb3Lm/DlR+sVpoWfZsHft4YxF38UvpOVRfubwAiTUwOd210kr3VHocVKwYjUDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924196; c=relaxed/simple;
	bh=aUqSZx5Jyb/Fk1gOVNP06/1f1jP/+rE+8FXc33EN0Jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nTfgYb7AH4nknqvrJF7GLfP0/X1kBBRcgITUEMFWOq3VAj8/KSSbTPUst68BzNYqNTNznYMxShd5WYUCJHwbqVc3fAnijfElaqa2cSCKxHOW5k6bDJZp0fT7NujIrkwjJuUjgd/l2PiwRj8WgrQKloYHvPdPIsd4gg1RCqLj6Iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q62+WyGJ; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q62+WyGJ"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso30973a12.1
        for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 13:43:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791924193; cv=none;
        d=google.com; s=arc-20260327;
        b=LUdIvhIXORt+HSxTPoJZbh1w23BprnAlNFOed93X5pY381qjh2ItMAyg1AaY/zqalP
         vj12zUinC5m3YiqToFZkRNsoJMdWhpcPRVE1wNGhEr8XYpHX06JmGka9RXk2C2xewZxd
         /ZY6sb+hGBs5Ypwa2mqxTWJJ3FXK3k5jY+HgEJLryaf0AEG9fwKtRRMme+yrvZZxeLKv
         shl4nfuKeBk+wuoH/jGlFeRDH7GMwhiCU5Gbsvbt1mhupOB4zlOpm7jNwSUCmUnpQlrd
         Avz4Y4nerpAknUB24zLW3grozDrLC9K11AGC9hoRro1a2y9g+djSMZqW1RiX5Wg3SGpg
         6Z2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aUqSZx5Jyb/Fk1gOVNP06/1f1jP/+rE+8FXc33EN0Jk=;
        fh=mtMNO/Hg0HNYfrs0laNQqLzW26sUWcmnkUh1TbkJHQg=;
        b=JEX0CS4EOhAStYCrYerfAdn39KTtN3jbmZ5BmZk04LP8OMZG//d/aZiMWiwFBeitK0
         u7ByyWdhGMqx9xtz5mTgO8SyVU6oCDKalxC2CfKaI7Iwd6p6F3ilzkPMlfKwlqUr+IPC
         IDjjGXBgwBbsK8iKPxLYP8YBYaHwN+Wy6fkghmHtrVhGV0mSDXkonbSViXPBiLsnLhgT
         EgWiZB4pPAaBnGxH9V6OwjuPIl8aiRw3tMHyWVyChowTUmcIJxBDbAtNMFNIczdAtbwN
         dE0PLarImgHic/9fYW7DU+DyExJAmx1xIuxjwBT3+Xvd+acMH/NJVA4oY1nqUamnlMzj
         5iSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791924193; x=1792528993; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aUqSZx5Jyb/Fk1gOVNP06/1f1jP/+rE+8FXc33EN0Jk=;
        b=q62+WyGJx0o6+n0bq+ylDWfLrp6hXuGk20MKroxXYG3aPjUXbLfrSx9KM5A3IMUSsF
         QMffXnolrTBUzbPW4gF05ID0BM7wGRwQ7DrZ/YPL+2V1TLrL/i42Egeta+JFkSd0ldNP
         h7lC2a7lkJS/1UkOigwg1sJMoBXajFOXBezhglNBOrS97dk0Do9q4NFo4CnMTmPvZy9t
         AVm4nz538l4GFuIP6rXAqJObXAnZulF4j1fzWjUpNN9QKQR1W+byQH/LAzqz5q/1twsn
         TSOR0Wkrapnzn8KcpneSuRYXCoR1rQNVeSQYrdzuc6b9aFRy7Nuid1XifvtYYn2qkkCJ
         BO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924193; x=1792528993;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aUqSZx5Jyb/Fk1gOVNP06/1f1jP/+rE+8FXc33EN0Jk=;
        b=WyxIFqO9ouiDpyxo96/OfIGPJA5IKA6UJUBs7T+jNf/mm1kCc3bXrh5X7+irmVbgVj
         EH24N3W2FsN3sYKSMIVreQkiDi6je+q2E+i/hFyz8HlAnjrVreoidtHzU0c80kRWBDX/
         h+BTgk2fsUdKO0q6cR8e8T1NniI+Q8Pc1mzzDzeFW3mmiG/1PfAyFWOFJMLgTeTSEDfR
         YplyTuDOF+MB1hwADlpe54QPfoHW6d79DQNh/q3Viik/0CcN9q1q5Dg5j4kHe/EbciSJ
         yUMn7jbjXsInyXPVKyFG3xNcbayRW67Ls8aoyxsy+7lRkbrwavuyVg7lM2ZzXMqa/yyz
         gxXg==
X-Forwarded-Encrypted: i=1; AKwUvBwjR1pe7M5rOyAKtqPQsQzvYHxJCMyPUDwjo1LvEcqZXOlo1PgaTa4ION+VogkFH1oiic8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIcPRyhh/sHTYyIjAuKL7mEy1fqoVDLuQggDDT4WQ6Xvj321Msl
	LM6pswMRWCVm3bNvYNazYY7zQK0P6zTaaqcah9z6Z9KT9y2cFHn2LijqcWRkieI9uKXbrfUTB8q
	Yh8r22Yw+uARawaviC4O8yqruKPEaeUUFvW5C4/ZsYhJ1CRprmF0QmL0y
X-Gm-Gg: AYBFou1fNWpo/MbDNeHF5jZUMk6zg4SSi45x9M2yVBL9MPFVnlAde0oXsTCrIEzRiPN
	Vn9hhM/n3CmEeHNaV93wg/vuJFm8BwRuysrNGotFUfntpKNkQdszskvUm5NWyn5n+Wtv2hA5wWg
	c52mw7WXghaB5/rGwpDBal3sJZ1vLB12Zt8n6mgT2FBA4SDEmy1SVQ6qg7O3W18pvJfvuS6He/d
	SCnIAeVtM8IRlotAogZvGy3pcaOxOVCARMBLDRaO6dI2M2vmBbKMROImCE0JWCLqGwaKN1x9crj
	scVp41WJzkA2N46RFLtUGr4lPbPQ64sQ+JkBHEqEvn9EXZCOPHnIVzI=
X-Received: by 2002:a05:6402:a593:10b0:6b1:d313:16f8 with SMTP id
 4fb4d7f45d1cf-6b1d3131c5emr128393a12.0.1791924191858; Tue, 13 Oct 2026
 13:43:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013195358.163375-1-yosry@kernel.org>
In-Reply-To: <20261013195358.163375-1-yosry@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 13 Oct 2026 13:42:59 -0700
X-Gm-Features: AclHuK-YmNn8NSDVLimMh9Yal2P17VNQJ0PnXTL8TAurb31p4J1MK23ZmaxEhr8
Message-ID: <CALMp9eRDjH=GgeCUe50JngFJtup4Lx2t-uHgpyEwyVB9VjQPVg@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: SVM: Update tracked pCPU on pCPU switch
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 12:54=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wro=
te:
>
> When a pCPU switch is detected in pre_svm_run(), update the tracked pCPU
> and mark all fields dirty in both VMCBs (if nested is initialized), in
> addition to resetting the ASID generation in both VMCBs.
>
> Commit bf260dc9e7b8 ("KVM: SVM: Trigger new ASID allocation in both
> VMCBs on pCPU switch") reset the ASID generation in both VMCBs on a pCPU
> switch, but only updated the tracked pCPU for the active VMCB to avoid
> unnecessarily dirtying the inactive VMCB. Leaving the inactive VMCB's
> tracked pCPU set to an old pCPU still allows an ASID allocated on one
> pCPU to be used on another:
>
> - vCPU runs with both vmcb01 and vmcb02 on pCPU A (both track cpu=3DA).
> - With vmcb01 active, vCPU migrates to pCPU B. vmcb01.cpu is updated to
> B, asid_generation is reset to 0 in both VMCBs, and a new ASID is
> allocated on pCPU B (setting vmcb01.asid_generation =3D gen_B).
> vmcb02.cpu remains A.
> - vCPU switches to vmcb02 and migrates back to pCPU A before
> pre_svm_run(). Because vmcb02.cpu is still A, no pCPU switch is
> detected, leaving vmcb01 with cpu=3DB and asid_generation=3Dgen_B.
> Because vmcb02.asid_generation is 0, a new ASID (asid_A) is allocated
> on pCPU A.
> - vCPU switches back to vmcb01 and migrates to pCPU B. Neither a pCPU
> change nor a generation mismatch is detected for vmcb01, so VMRUN on
> pCPU B uses asid_A (allocated on pCPU A), which may collide with
> another vCPU on pCPU B.
>
> Because the per-VMCB cpu tracking is shared between ASID management and
> per-pCPU hardware VMCB clean bits, also mark both VMCBs dirty when
> updating their tracked pCPU so that the inactive VMCB does not run with
> stale clean bits when later entered on the new pCPU.
>
> Fixes: bf260dc9e7b8 ("KVM: SVM: Trigger new ASID allocation in both VMCBs=
 on pCPU switch")
> Cc: stable@vger.kernel.org
> Reported-by: Stefan Teodorescu <fane@google.com>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Jim Mattson <jmattson@google.com>
