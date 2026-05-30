Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ABF288B8;
	Sat, 30 May 2026 01:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780103124; cv=none; b=t50cOoam8C9CJQU39zj7dMYFrjqTZTywJQbnVieH5JlG5Hu/7Qit+/C49QVyta5qx6Yr49JK/3W5I8Jqu7mkEdRZFoTfj2sq0qbbzC1Ch9ZFwWfdOU2WLp1looH/O4GQyBvnLm1Ue6KZxFnSVDBr3O5RwzGnvi8VqWEksPMciCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780103124; c=relaxed/simple;
	bh=Dlzr1rDE8L+z9TaFsIQRYj+TDt4DqD4S8TJDvSxH4tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBVKjjSF6kZgtB/vk8PEV26FypbMvVSlaVBTTNyDkdGXlxXmmfTYO9IEBoSO71PTPmxYpydKBbIrfPlOFTuYlN5Ij6bwSebgICQzVU4XcsNCohGSF6Y8f778zKCMtwZn7LqB1rBH+JwNXHWpSbuKk4UMQIzEN35jA/1cJNk3Te0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpAfBTzq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpAfBTzq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102891F00893;
	Sat, 30 May 2026 01:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780103123;
	bh=4N6VtRa8W9OZQn0omYmbrU26uT3O9GudrCtnPZKPXvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PpAfBTzqNGrZ/q+2SDvp5a+Rj31RGaxNLdxu81LScqWYxYgDqWmDtT/sQGx6xQc8I
	 udd5hyisN1gMETRIEWb/bcOnbf+BNhxuTGHHgYSe3l666eZMKAvvFEy39kedSOTO+T
	 9rkzNf0Pfk8ZyTb9ndaGNAVk3Qex57q3CKhVGPJfVm1yGOK8tG1R4w34yDsU7Jyhth
	 fp1ptzhgTSQkGrwodldsfbfDpyA5mwiQsEmLBxE53yCZLnAWIouHqGFRzTivzrZWhc
	 iDo3Y01jKvRRM3Mi1gKU++VMugu15RLyRlombsexAUVjQg3vZdhK5OzMcww/e79Nu4
	 yqv5kvcT9l6uQ==
Date: Sat, 30 May 2026 01:05:21 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCH v3 34/40] KVM: x86: Move misc "VALID MASK" defines from
 kvm_host.h => x86.c
Message-ID: <aho3nf_m0bSwy1Ac@google.com>
References: <20260529222223.870923-1-seanjc@google.com>
 <20260529222223.870923-35-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529222223.870923-35-seanjc@google.com>

On Fri, May 29, 2026 at 03:22:17PM -0700, Sean Christopherson wrote:
> Move a variety of "VALID MASK" defines, e.g. that capture which flags in
> a given ioctl are supported by KVM, from kvm_host.h to x86.c.  The set of
> valid flags/bits is very much a KVM-internal detail, as the hardcoded
> defines are often massaged at runtime, i.e. *directly* using the macros
> outside of KVM x86 would be actively dangerous.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
