Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D432545560E
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 11:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791372295; cv=pass; b=C5EDG0hWTjgj/AoGA4+jklxJiwkkq1+tu/jSS2lbyObLTKT1CEKOkcWU5h9hcMpA8BO2mRQ6CC7FZyX3Mv4vs48T2mUDXAcfM3QKbwGj+ZKjL1B9mV5DgWdNj8G4rkc84Bo5gLXeJ0bgz6MDXysUmkzpudLlTTgc1t2Q4EUrurQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791372295; c=relaxed/simple;
	bh=e6PnbIvoXOZFv6pPRVmqWiNMYIregQMXJAxqLvuHzdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ag1uSxHeGc0/N1uSJuSsOVwtbkFglXBTBBjsULQXD8AHMnpDku6nQedoRoMqcLCG+ihMaFrVx1G7jmD8LMKq/rKsC763O9Clnyf2rPOxcnD6cOPJ51sN5Sm5fG908clnebDCUNjs4o7EKc+1wooylgrM8JjU4eSubdfWKVqiJXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=viYNep54; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="viYNep54"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5bcbb378fc9so8058e87.0
        for <kvm@vger.kernel.org>; Wed, 07 Oct 2026 04:24:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791372276; cv=none;
        d=google.com; s=arc-20260327;
        b=nrXaXTHCjs5mlNuDSypgAdNHFYWzGEbDGJPKrwA9wHE5FzmwFKKfUNM/2EUewSXQcr
         J1TyKV3fZp8TvG7YoaqUNpPfq9tAQGoPZkT0HATvk5+XeN8FrsIzzNwPQxWDXMfhAy4f
         rdSbWCbDDDjT3jr+kvs9vA5pkYyrm1dPNYr9ruM1x10ui8rjm5seaktxdTIVPzUcKt6Q
         jrsQaUyORsDfwqs2hG1sOHX2mOlHeM6lBk465iwpbnSLaUHI5op1Qbhw83Cw7UsqkxW/
         0vDhiWts9ritXFZ0b4BJIh8h1aRC9Az+J7AiQEf9B++03h+YpGMlxf7OYlJvykQrzvxC
         AqcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=e6PnbIvoXOZFv6pPRVmqWiNMYIregQMXJAxqLvuHzdE=;
        fh=rnIkUf6r+pm8oCQPQDOHPhdYLJEIYxB5Eh3hMNjkNs4=;
        b=GpOpijWL9/h0+x4tIRaukczj1eyCOhI4dTsG5y1xvPo5dRd/zjVkRWWp6MprdALC5a
         6w2SlxFBTcNrJTrJRPSCQ1oOb4enaMUOe+eEs9pShqCHxvjJQuZbTEm3JjrtqL9WFEVS
         pFjt0s9BBHlb0NVt51UuV2MD04ePDCVu6pawII8TdSrv51OuCEp+pTcQQqLk415hLfGb
         H9CmbK677k80xxPBbnCKQvA9h5WWUs5ig2Ncud9dKrImaxCuBZTw4SIEkp4Xec0Qp6ti
         L1IePwEgKYw00uKyKe7qDVp11cksWilea+7Zz6oreK/tXUKliwX+/3l+Tl0g9tVtpZus
         X/hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791372276; x=1791977076; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e6PnbIvoXOZFv6pPRVmqWiNMYIregQMXJAxqLvuHzdE=;
        b=viYNep54Y8bhDRmTRxuG0pzXcRCEzzH+gJi32PD7gChGRsdph9djpcd+wFH9oospc1
         KOEbdGl9HYM7qTx1RQeGR5vzkhPzA2bewQwQcZGdanTd10BbQ/aywpjlizdyikCquzCt
         nbrJ7SQwpJm/s1ADdIzthIekFFSAOl25/auq2j6rp6omXhja4cEMGTaIXtw7iB/oGXGa
         7OZa26+o1M+XLuvu7uwX8jwge1+O2KRKNkZ+wr0JQOdj7g0c1tMz3WDS7a1nsSGTAxEu
         /T2LdVJmo1J2qRrhIEU1YXPsDGTEOSDhLXwnC2NENW8Q/Heae2EZyWq51hSM3O2lhQZd
         Oe/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791372276; x=1791977076;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e6PnbIvoXOZFv6pPRVmqWiNMYIregQMXJAxqLvuHzdE=;
        b=p3sUyp+E8vOhk7B82GFJfhI+BjWyUHtOKAb6KZmyHsueJxkBRvmdjWGSXann+kLdbN
         LgUG8zMZmUQqjIIltJK+L9+0/XSh/rMIaCCq05+yXrMUIXNqZgWxVRf6kBvKkqSRA+dx
         OfyCZaHEmNt4PxH9/EJdKQx2jghdvwt6na2i4k6eWazeoT3d8AcrQfnvfDY5qsMR+M9V
         T1RDCRcEEh8IhoH78obFBfGp9J7j+Ar/T/AH7jdLlBCc53E5mTUHCijcX8ddLB3iBuCO
         N6YQyP30QDEred3VYyNzChW6RQ/kniOe1RVd8FuODZG9Sn1wwAQ02q/ww5acQ1D7aToj
         9RBQ==
X-Gm-Message-State: AFq9FYLGFc+fG5ZHd48/0mJLfC/NUJ5xxbixQ0OCk1jJ8mQZUsWh2ElD
	3IbClzQA8+M7DOZXvp+xStcsibPuzdbiGQQbN1lVKNhUXDR2ALtxsdEf9VjDnoskGSF5m6slys7
	uzuXwLHFp3p2Yx2AWn1fzyDZYusqBkbpE3n0mJVPG
X-Gm-Gg: AYBFou0m7M/8yKUHGgfvSpjJI0ASFgxIMSfU68d4E42B5C7SBnwNqiYXM+z8fib5fE9
	m3StPXPH3vu07T7F4QKk6CaPH3LsZUo1t4DblC7PNeFIY0MK+tSh7/H6oMj11uUDfZF7xZUFiJk
	9K3BcUb5LHpyXP628KNLwZlJ4jEGtUI9+g6gurk0gP7bGAbwzh/WtYaAaDufeX3wv8EFNMDHCvv
	pnoN66dPfokyXigNgDfWJYUcJd5j86LyqzQRYF/iDT7myDa6aA971QhiFYpWxJkgzsnNHaWR8NV
	FzT7cJFGg9IBQhnu86/iqo6zwzFUKYVJ+9/t9YCuPHdXtDGBL3sy/Q==
X-Received: by 2002:a05:6512:3f0d:b0:5ae:cf5f:4a88 with SMTP id
 2adb3069b0e04-5bcca857470mr320723e87.8.1791372275119; Wed, 07 Oct 2026
 04:24:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007073537.2454351-1-suzuki.poulose@arm.com> <20261007073537.2454351-10-suzuki.poulose@arm.com>
In-Reply-To: <20261007073537.2454351-10-suzuki.poulose@arm.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 7 Oct 2026 13:23:58 +0200
X-Gm-Features: AclHuK-AkPhTBNuRx-Nil52s88bZX1XXziZHk8i7cIYK8SeGo6JUTxyL14CKqt4
Message-ID: <CA+EHjTwHBasTofGE5YQj0WfyN3v-uHykPxRL57AWJGhAO5Pojg@mail.gmail.com>
Subject: Re: [PATCH v23 09/14] KVM: arm64: Consolidate stage2 unmap range into kvm_stage2_unmap_range
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org, 
	will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, steven.price@arm.com, 
	aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com, 
	joey.gouly@arm.com, yuzenghui@huawei.com, linux-coco@lists.linux.dev, 
	gankulkarni@os.amperecomputing.com, sdonthineni@nvidia.com, 
	alpergun@google.com, fj0570is@fujitsu.com, WeiLin.Chang@arm.com, 
	lpieralisi@kernel.org, enju.kohei@fujitsu.com, sudeep.holla@arm.com, 
	jonathan.cameron@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Oct 2026 at 09:36, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> In preparation for adding VM specific backends for stage2 operations,
> nuke __unmap_stage2_range() and fold the logic into
> kvm_stage2_unmap_range(). Also, make kvm_unmap_gfn_range(), the only other
> user of the __unmap_stage2_range() call the kvm_stage2_unmap_range(). Also,
> while at it fix the comment to make it clear that mmu_lock must always be
> held while unmapping. The code already mandates that and the two call paths
> do have the write mmu_lock held.
>
> Later we would replace the logic in kvm_stage2_unmap_range() with VM
> specific backends.
>
> No functional changes intended.
>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad
