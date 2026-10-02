Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282434D4896
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 14:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790951869; cv=pass; b=lGS+iyQcwCVmnr3O8AI9kTy8xW6PtRDwj7NCzQmA8yFm8BCDu5gGpcGy/o3tyAUfRnsURMsw9FkDgJ9PHroj5EgvI6yydgJfephsoWpEfqMbCOErPjNuoy66hm/DLT8c6eu50CQ73EoXPwWvh2Y/x9xyU80NGNaTda0u0XUE3qI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790951869; c=relaxed/simple;
	bh=bvtdEPxwSQXjnHdQcA79svDgXzwZQykpi2V56CMH9Ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A2EinpTwacIS2Wsie3BsLb4NYRHJFxIaHOpKh/o5XzkfbjT7tjDYW+1RwrsmnjIfXBIXTrQusLxpy6rfbZE/CCUg+RS4EjCfwFMaSLadb9YxVUpV5/P873nrkkIWToNc8dBxBN4lOfBHL03a0Denrs4cWHD0Am3COt37vJNy4ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o/24jV5t; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o/24jV5t"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5ba3d1ea20cso8046e87.0
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 07:37:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790951857; cv=none;
        d=google.com; s=arc-20260327;
        b=mIVuYk4RXGMRZQmCTEOOwE5QseDJzGmjky/GSsGtHRxPg/Ne3G8Vbb9qqscwyTuNLT
         A1jW9aFl/Lg0MIuZewKxwNfZfIDkWVp8QkzZcWQeP65SAlSi47D3idN+uIsWV8CkdDhQ
         0rsa1vV1b7njdel2N4SxsobomCjh8fJ9HZGpMcdCAp1Yq1jZqNcE+SfRg0fNjBzQa9RD
         xFuPGFkIa1YWNdXlCB53jsHn5sfWKBDs1qq8/V6ai05751xtd1KH3oOBNSlCyNQKbtLg
         aV6X8Js8q8foVlom9BUzos29sUZyO2WT6cStWLOYhX07mFsT8qjpSOptnQLbP4CTkO6q
         Qr8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ngc+Dc6mG5eMUNtbuXMSrmBLpP8pJzc9TOtXps7kTTo=;
        fh=VompkBVPWXMYYfGvMy3+MfRy2Vvr4QVO2Lh65gWyU2A=;
        b=BEV/dYHj+ZDwps6u/4IKWxlqXgDSyxK0GcRGE6PnCNIaYid0409OYn7GzZWKBQ5yu8
         st56oPLfxzcrd5Rfa6x50nTcTMX0J9+UyFj8NPGNKcvfKKkSes3jryziLwd6d8jCKwLb
         cXPTUfr+4LDLzfBzYsVQRsN81fodvO4mKv/Uz2iADuQA9ah+KmD5XWRv0JDUwmkFgSVa
         LHgcSSZHF+dKcP81SfyyDImgzE9bLxAKDopeFce0o2xxepcYUBagsYPZ6S4IRfjuDHiv
         0Kv+xbocXDGBBsoaZ5evfcW3uxYd2dTQkFpKeaOMNuzDxcBxzw+RRME74sTHrozznW4S
         Sq3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790951857; x=1791556657; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ngc+Dc6mG5eMUNtbuXMSrmBLpP8pJzc9TOtXps7kTTo=;
        b=o/24jV5t79Bm2Zt+VQM5tDH6jq5vNUw++e662O4aqTtYvWtbG9A+zp8L7S0pu0Kyw4
         LNV8ITbxzYdKk76PNKIslnPJasWrvu9tny78dsR3IbsBqqL3Rn16uEIz1E0aQXnnORPY
         PKMKJoYVjh9rpyT4OjotPp4obAmJCd3aB1r6DH2RtCOsUJeDlFq+msvKv4RTTTBzMkKy
         n0yTpCHc+1eCqQ7zgM1EwINd64FyI+oVlRo/M5EdLUHYafvZo+NpBod9iR4I/F22+QjQ
         2RHofRLWhnBupkIXZQGgNTiMzplagMUmUKRfzvAP/benHduQCGJDD/iZh1TSfVfPL9Ko
         PDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790951857; x=1791556657;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ngc+Dc6mG5eMUNtbuXMSrmBLpP8pJzc9TOtXps7kTTo=;
        b=XbzDs1TfccDBaQpZkcRVS4472Zs6W9i8BRMKa4RFFI+SWty9L6J6cyf33sEpBTsgm7
         3tr5raWQIRTY3nhySuHPpa4LTK7gQrbfeYIh8HhXFy4UMICh1O8VUur8hmSGdZmfWh3S
         L6uOb0L8wmHg8XwiE0KnuOUESuvB1Y+3TBKq4QmAW6sM74KKvbk37RPAZ4gZIQgleTsX
         WdE1XlorjKx35yNloNEOCfYYFVuZadvKS8mERaeMjjgHzh1EHYaSfxl9QN780t17cWQ5
         QYuREuit7CK9gvZaZHaqE1jQXZaZI/Cteyvrg7IdI/Quvde8nC5+Lw5gcmVC0d0Coq9d
         +Hnw==
X-Forwarded-Encrypted: i=1; AKwUvBzq7U7uoyZeeejtafckUiCF4K9M51QiJ5kYNx5geNem6Cgj1NimCiMCtc77iYx+dWBBvKk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLSkdlBJJyOMQDr03vWqfsuT2FBwzlwShnCGLB4Itf+LxXbjk/z
	P/kPVo++GBa62bP9zG+jnXuUms2poyZwftyKUU5uLnWT0IuKrno314T6saS++C+mouI/Paki2lW
	IWsWE8nMUOpjxcLQuVqDsoEjsPA0g7TwofQ8M8xC8
X-Gm-Gg: AYBFou1jez/66IegDehCdtQeCZJU926gnZxFqOddeqtPbDvFcN9fbOG4HWhbxy0C3vk
	Sg9d3ENJu+1+Z8R5Z1vUOKRtgiesYbAyD4blc9GrCVYYqKMcLwzqg3YHaUCW2aqPffgL1GCWg/H
	JwaOzGu5qpiM6BRalwhWVlbqW+2qiomneOG0mxZjmS3KfFmx/2tBk9OrQCIgZR5K7FmgOtZQt8V
	u5PR4eQcnQesV2b46/d3MC313LGSI6CLabWr6NbbIqUqPB21lLG+s7j0UeTwsNrFz9UU5fPdEQE
	DZcNi9auJXCd7N2Mh2fCLMCPbwkrrZAwP25ZZKn1V3F77WmUzCWqTgxZ6nNCok7J2Pxv+I2fqKm
	qc3kqQoER5nJoVQ==
X-Received: by 2002:a05:6512:3da9:b0:5ae:cf5f:4a88 with SMTP id
 2adb3069b0e04-5bbe07ff87fmr127412e87.8.1790951856416; Fri, 02 Oct 2026
 07:37:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001210703.1597150-1-suzuki.poulose@arm.com>
 <20261001210703.1597150-6-suzuki.poulose@arm.com> <CA+EHjTxtatPyGcyvEyR129cqUiAYcO_cxRVtwZO0ckZsOnD7TA@mail.gmail.com>
 <86se2o2rbs.wl-maz@kernel.org> <CA+EHjTwHuJ0u_TTP46zNFKFmBP124XHHLUVhkAUSyfhe92=41w@mail.gmail.com>
 <86pkxs2npx.wl-maz@kernel.org>
In-Reply-To: <86pkxs2npx.wl-maz@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 2 Oct 2026 15:37:00 +0100
X-Gm-Features: AclHuK_ts2oonb5gFFEThD7Rzb_QZk1ok5N5MoHVdkKoZ33EulrV9BUtxD17tPM
Message-ID: <CA+EHjTy4rb+6z0bqh7sPqACES0EDpURdeoyiFGmdw3p0PENcOQ@mail.gmail.com>
Subject: Re: [PATCH v21 05/23] KVM: arm64: Track the type of VM in kvm_arch
To: Marc Zyngier <maz@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, steven.price@arm.com, 
	aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com, 
	joey.gouly@arm.com, yuzenghui@huawei.com, linux-coco@lists.linux.dev, 
	gankulkarni@os.amperecomputing.com, sdonthineni@nvidia.com, 
	alpergun@google.com, fj0570is@fujitsu.com, WeiLin.Chang@arm.com, 
	lpieralisi@kernel.org, enju.kohei@fujitsu.com, sudeep.holla@arm.com, 
	jonathan.cameron@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"

Hi Marc,

On Fri, 02 Oct 2026 15:15:06 +0100, Marc Zyngier <maz@kernel.org> wrote:
[...]
> Honestly, we introduce the flavor stuff to make it easy to match
> things on a particular VM type in a readable way. So why isn't this
> reading:
>
>         if (vcpu->kvm->arch.vm_flavor != VM_PROTECTED_PKVM)
>                 return;

I know this is a sketch, but just in case: that's inverted. The sync
only applies to non-protected pKVM VMs (EL2 ignores it for protected
ones), so it would be != VM_PKVM.

Otherwise, looks good to me.

Cheers,
/fuad
