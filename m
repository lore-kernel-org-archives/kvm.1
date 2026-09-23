Received: from mta0.migadu.com (out-163.mta0.migadu.com [91.218.175.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC49493D40
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 11:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790161307; cv=none; b=PalvrwHXOIcqm9+ajXjCdTXjioQQAY36MhNBX8XSEkf4/VVszhZd4n9D2FQsfjzTNnOpAlm63StPIo5qc9uy5MWLIXqyGXSErckfNJVmbf53pOQXVpsDdCrjZRy8re+eQOVDMH+sb+TB38RJe70CQRpw7IF3NfmLwGsnc3AyHIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790161307; c=relaxed/simple;
	bh=5K+iPpF8DDgclPsRQeL7zsBmY6cYvKrH6RbiTc5jglc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=II8NtYLZxKB60xqvW5fKF64fJhBdJu6mxIqUw2NtnBMnH0G2ZAHp8bnnOidLIvLFeXvcVxyQ6dR1tMzYb8fEcQFBuFluvmDPfdhqBZHxkPdbbn4ZIolHm8uVSj+h3eud3eICUQU2ABfkJZnFS/mV3Bvy+YaAYY8n4vKwSrxy7SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TKKaryU9; arc=none smtp.client-ip=91.218.175.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TKKaryU9"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5K+iPpF8DDgclPsRQeL7zsBmY6cYvKrH6RbiTc5jglc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790161297; v=1; x=1790766097;
 b=TKKaryU9BxGYWZxpAFV/3MlIrBYtlLnBz3/yEKLnwmlwRWP49yQKT200swXSXtZC51c/jB3c
 7p00VbPaO+mbjabjTjAj++sWHevmvRVUAVScl3FsOQSHaG28D+mkUdVWmJM8qBkVmihFUqgIiiv
 atOXJq20Bt6ceudte3TTXadE=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1fd6a6d180a7c459;
	Wed, 23 Sep 2026 11:01:37 +0000
X-Mizu-Trace-ID: 1fd6a6d180a7c459
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5b83c1421ecso4469e87.1
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 04:01:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz/SdLG2M+9Sb1DJ8TqkXRNSsOFHiYD0GCY2oMfCL/jXoJaQGMPnNOJbrtbogV0rYFf+Wo=@vger.kernel.org
X-Gm-Message-State: AFuF++mXEjWyWvLO7Jz1cL+BXM463q9N5y8VY8GRrcJLoUfzn5drFDVh
	b4xEORDv0OPKYmtplzxvZFqMTak2DZK9QeDXGoNeiLkaCk5zMpJSmjGMsQ6VqzmVWdn0l4GPedj
	LAkqOTj6UgiT/gjKfkFqhY38i6i7HhB2JDA3bq2VD
X-Received: by 2002:a05:6512:648a:b0:5b6:4ad:d6ba with SMTP id
 2adb3069b0e04-5b8d91673a2mr101791e87.15.1790161291757; Wed, 23 Sep 2026
 04:01:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922-kvm-arm-prefault-v3-0-787bd3bc7e3f@kernel.org>
 <20260922-kvm-arm-prefault-v3-7-787bd3bc7e3f@kernel.org> <20260922143157.0E84B1F000FF@smtp.kernel.org>
In-Reply-To: <20260922143157.0E84B1F000FF@smtp.kernel.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 23 Sep 2026 12:00:55 +0100
X-Gmail-Original-Message-ID: <CA+EHjTziT=qEvCpjGriVhC5g7=nyQNfvEQenw-JXSJuWtJwTRg@mail.gmail.com>
X-Gm-Features: AcwNN1VlY5oTU2GdC6G6YKOfl5LmibKipPAp5RDM2yTy_ZaXda-g-wUfh5go1wI
Message-ID: <CA+EHjTziT=qEvCpjGriVhC5g7=nyQNfvEQenw-JXSJuWtJwTRg@mail.gmail.com>
Subject: Re: [PATCH v3 07/14] KVM: arm64: Size the stage-2 memcache from the
 fault MMU
To: sashiko-reviews@lists.linux.dev
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev, 
	Marc Zyngier <maz@kernel.org>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Lorenzo,

On Tue, 22 Sep 2026 15:31:56 +0100, sashiko-bot@kernel.org wrote:
[...]
> Does this decoupling of s2fd->mmu and vcpu->arch.hw_mmu cause a spurious
> allocation downstream in kvm_s2_fault_map()?
[...]
> Could this lead to an unnecessary allocation in the ioctl path that might
> spuriously fail and return -ENOMEM to userspace?

Sashiko might be right about this one, though the mismatch comes from
patch 5 rather than this patch: patch 5 moves kvm_s2_fault_map()'s pgt
to s2fd->mmu and leaves the allocation check above it on
s2fd->vcpu->arch.hw_mmu. Could patch 5 switch that check to s2fd->mmu
as well, the way gmem_abort() tests pgt->mmu?

This patch looks fine to me though.

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad
