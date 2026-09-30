Received: from mta0.migadu.com (out-209.mta0.migadu.com [91.218.175.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F6047127B
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 10:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764081; cv=none; b=NRmY6P4AA0ayz3lEtQ0NhroJlIiT3T3lDllcKKh6sgnCaT+18E8Qp9JUOu/fUH402wElv40iyfcbkzYcOjJHMuj6u4s3UFp4FcANWfCFVpdPIbJ4GmJzgA1+/t9QJ9xNocJAwo647xcqB3Viyeo4dm/ifwxi1/7f95O/7rEfrn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764081; c=relaxed/simple;
	bh=/J7FDCknwMONLwnuF/qlU07GuECyKi8lksm5VPBahVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGlHPFllZ31UQe0U1N6ZFo0GacJbJABSr4CTDyinkPcL3ShJ1GUgamOdKiWYp/PrM2jCrC+jNHUYkm4Q+Ak1VrVltCDdbyap/BBOQefB9o+WpQU8giuZfnw+H32jZ2jcB+k/xfiP8FK/58C9P5G+tQgEZfs5b2Hm8EwfKYYylWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n6n8Ea+W; arc=none smtp.client-ip=91.218.175.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n6n8Ea+W"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/J7FDCknwMONLwnuF/qlU07GuECyKi8lksm5VPBahVQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790764074; v=1; x=1791368874;
 b=n6n8Ea+WEkd9FUW7TAjttwXKqCu0u4/TCmcs4kkuDnRc9+metHFRh5qvidhEeDLVGMILUnsQ
 M1JuzHalQiT372IDSdqhSEK4DYrSGIbW1DJzHbgceQSD2VR8RHP92mTnsZVmOPw76oV3ovkRskj
 I/ldkmQQqczvEFFQnRJAyBAM=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0e9b1d8d130e3b7b;
	Wed, 30 Sep 2026 10:27:54 +0000
X-Mizu-Trace-ID: 0e9b1d8d130e3b7b
X-Migadu-Flow: FLOW_OUT
Date: Wed, 30 Sep 2026 12:27:53 +0200
From: Andrew Jones <andrew.jones@linux.dev>
To: Xiang W <wangxiang@iscas.ac.cn>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	pbonzini@redhat.com, thuth@redhat.com
Subject: Re: [kvm-unit-tests PATCH 6/7] riscv: efi: Allow ACPI boots
Message-ID: <wpaf7nksxsprt76pibwgq7a5zrjudhqfthv4jckvdqgai7nvss@7mq3o3jjlew7>
References: <20260924033945.176581-1-wangxiang@iscas.ac.cn>
 <20260924033945.176581-7-wangxiang@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924033945.176581-7-wangxiang@iscas.ac.cn>

On Thu, Sep 24, 2026 at 11:39:44AM +0800, Xiang W wrote:
> riscv/efi/run rejected EFI_USE_ACPI=y because CPU, timer and ISA
> discovery aborted without a DT. Those paths can now walk MADT and
> RHCT, so drop the early exit.
> 
> The existing runner already omits -machine acpi=off when
> EFI_USE_ACPI=y. QEMU virt defaults to ACPI enabled, so no extra

EFI_USE_ACPI != y

Thanks,
drew
