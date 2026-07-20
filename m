Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A561D449B0D
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 21:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784583513; cv=none; b=HT94eYLcAMdj/c/0IdmhViU6svDzoZSOR/D9lVCidtNvKh3d9fvzm19RJAlErh0E/DeeEcz2DxXzV1mcusMAy2TSqb/WJpGmj2AhQBwq6Gm/edJVHEmXW+9pIAkcLg+9vndiuYywvgiogupU/+KoT1qrlGKRSiupxmDQn1p7Vng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784583513; c=relaxed/simple;
	bh=fgqOdfqGehyPp39uBRzhkJKpjE04+TA6AHiAA/V8Uq4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EDkhetze07CDD6U/UWujrdzj3VVGALKF5mk4+Kx5/qiCWeC7g48UPpcKqVXRyG76w6Crs7FftYmjWK+51pz/Rr+inpI4pt23ebqQcnU1423yUJSzxLZdNTas/jRqcOviPQx5YBmuE8wavCLQdrD4NSTAGFIAyzFvXrpWOweyhMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QqjV8vZ9; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QqjV8vZ9"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ccb6f6a3f4so76775955ad.1
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 14:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784583512; x=1785188312; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kb+H3gD1/z5LwqMW5Zz4TLwHZH22H10KWNrwvGv21eU=;
        b=QqjV8vZ9oe+oLEVLk6dd871KaZwAmeg/vZ7X6PSRuSbDdH203Rjyxekz6W0hSfNoOB
         Xn3aNWtDGkl+rFKtMO1sFY2jTuLBlDK8gPJikFwJhjmrnkiROeSHq4GmcyCNX9OqsrJ6
         XMV2hlpnv+EZ0zCNmTfQ440JK6T5E24ssFNyMpaem5CMH9N0RSsjKGUwzR3zC+71DDZU
         rWpZ1cElkrjPuzaZiVM3A5WFjp8S8BqhekvY2h4X6rmBrCfv+DqmTcfAqEZkirYqo4CE
         mRdF+Cu/DsYZNahi8CGJuR8lIAwiP1Wml+W8Ni3o7XW1wFmmgSFb+XDmSD2A8Q7l+oo5
         Wcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784583512; x=1785188312;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kb+H3gD1/z5LwqMW5Zz4TLwHZH22H10KWNrwvGv21eU=;
        b=S6od6Uqo9oXlC++U7JzQPE16JMRt/h7pRwx50krnuQ/rjC/0CfqUmRdkRcbBVQobfT
         JKBPlzzWfaluV50k423fD89aM0eaCIyjmqKqVUFD8FocAjMvwzMtmjp6uBz+HTf9/ysL
         SGlSjYkDKLsvIKaN5+4Lolo5w/XfaNlHooZ7O/g4cpOT/IyzNrkYaEiqjuh0P43kJ43H
         oGPZ0TlICRgXeIX2EsvUotm8JZaJevJpEDpy6gHk2Z6Pbo4OYAlBWJFCjy0ud1jM3AEy
         us6HAfOg+MZjdQAIAd3xWm4U0733Xz4ln39LxtiZ6ISU6pSvG54NSYgEL6/QBao718UT
         j8hA==
X-Forwarded-Encrypted: i=1; AHgh+RrY9NU3IlEsBIK98sRHT3nurctJ/ll8v6yDapjZ+MBnXtVhnndh0FOrFCfIfvXS85sy+XY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKV0sDSgo+BjmRJyCSwQQPcnHj/BNrR/AlwaA332vQjRnzj7bY
	EGotti8VaQjk7b007b4i5WprObb9HZDewoRs8MUrRIu3USJIX4xF60gvpgiaQ/GL+ZErvOIgY7K
	WwTdTAA==
X-Received: from plblq3.prod.google.com ([2002:a17:903:1443:b0:2cf:6c53:48ca])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d483:b0:2ca:f417:396b
 with SMTP id d9443c01a7336-2cf1f25625cmr211823005ad.3.1784583511786; Mon, 20
 Jul 2026 14:38:31 -0700 (PDT)
Date: Mon, 20 Jul 2026 14:38:31 -0700
In-Reply-To: <al4rNqpBYy8FGKPw@blrnaveerao1>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260716160801.3155582-1-dmaluka@chromium.org>
 <20260716162900.9D8131F000E9@smtp.kernel.org> <alkTuicE2ELcakS9@google.com> <al4rNqpBYy8FGKPw@blrnaveerao1>
Message-ID: <al6VVx1rKn46ZCUl@google.com>
Subject: Re: [PATCH] KVM: VMX: Postpone IPIv setup after successful vCPU creation
From: Sean Christopherson <seanjc@google.com>
To: Naveen N Rao <naveen@kernel.org>
Cc: Dmytro Maluka <dmaluka@chromium.org>, sashiko-reviews@lists.linux.dev, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 20, 2026, Naveen N Rao wrote:
> On Thu, Jul 16, 2026 at 07:24:10PM +0200, Dmytro Maluka wrote:
> > On Thu, Jul 16, 2026 at 04:29:00PM +0000, sashiko-bot@kernel.org wrote:
> > > [Severity: Critical]
> > > This isn't a bug introduced by this patch, but does this exact same
> > > vulnerability exist in the AMD SVM AVIC code?
> > > 
> > > It looks like the SVM code suffers from the same use-after-free pattern
> > > when userspace creates a duplicate vCPU ID.
> > 
> > Seems plausible. Can someone with AMD expertise look into this?
> > 
> > > In arch/x86/kvm/svm/avic.c:avic_init_backing_page(), the newly allocated
> > > APIC backing page address is written into the VM-wide hardware IPI table
> > > before the vCPU ID duplicate check:
> > > 
> > >     WRITE_ONCE(kvm_svm->avic_physical_id_table[id], new_entry);
> 
> Yes, this write (or just setting AVIC_PHYSICAL_ID_ENTRY_VALID_MASK) will 
> need to be delayed to a post-create phase similar to VMX.
> 
> The alternative is to simply skip setting the entry valid during vCPU 
> creation and to instead do it unconditionally during vcpu_load(), where 
> we anyway have to update the entry.

Won't work, vcpu_load() is called during vCPU creation.  :-(
