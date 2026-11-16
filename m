Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827724;
	b=4spAWsVtENMIMLo3S7k7wBftMZSxnAaL6sw/Njd32BVV2GVyZYR44vPFA6J9cMVp7q3o
	 KscRUfsnmfSm92n70YMXlysmpVYCw1fdVIEZ1G1Bs5Cxz9Ezj2RxfCRiM1vdR3Q9SUpgL
	 LWVgEk/aGwmF4HReRoc60U3d3KfASXEqgZOp/RDbVt2+17IXMctmrbv/M1FfC0KZ3Tejf
	 728S08ir/9DuU9SamjgBMLJlZquWkRlM+q+711mZXLeFLQFkEMhaheEY6eJu+31fOi118
	 +eM1ebMOZoUrSTU8359efM49lBdTWjO9rNaI+/yfvlvruadDIlQwKEuxt/+64ZWXxug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827724;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding;
	bh=VlOwmRJ6zFrXMNm4jjAsPeKlyueK5n2WoPT5vBxkKJI=;
	b=GnucDFu3U+ziNcDGcTLLkZJrr1ddMku0L+fBaY4tQGXSECzzw0fAWwvTfD/kfetgUmGA
	 0JHJVwqbrZoFXgZaHJoMKtv3IO234bR92+9bmgrFN5S/QkUn9SCvQfTj55ANsPER+yGYN
	 8K3tfUVhHWbsI7ZEyxK83KbOFu3/B5LJpjTmzR7YUqRDEcfPOLEYrFopOdiPk6MaL+Oca
	 P2U25irax3PYBdC5xdchu2wfOKBIBx4dWgYqRGaXpcVnQfxZMVOkqjD18xOFWMkHIaR0R
	 mnJb9EAtwga0cSioqU5kDkVXiO5+M5I0gZjH+xYjjl7YQalc0kD8c/xcM9CqEErv2LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=cSMqNg1R;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB43E606BE16;
	Mon, 16 Nov 2026 11:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB43E606BE16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=cSMqNg1R
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 320BA1713;
	Mon, 16 Nov 2026 03:15:20 -0800 (PST)
Received: from LeoBrasDK.cambridge.arm.com (LeoBrasDK.cambridge.arm.com [10.2.212.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0F273F632;
	Mon, 16 Nov 2026 03:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794827723; bh=oK5X7pOb5zR3dPUJXccq0aNQazUBTMDBGcS29i8/5uY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cSMqNg1R9Q2gOxA5Ggegka0ibVag1/eoYwD9/HVphzVtlyB/8Frrv5D0ngMmz6H0k
	 o+9jIjmvWFoGHSjD08gCpA+fqirVXuCztu9GTdQr+CUdXRvwn1zPT9d0/rFGOyn1Y6
	 FV3TQI0xpWXCqmMDvokiqkvCDfMBHLbhp4b0CyX0=
From: Leonardo Bras <leo.bras@arm.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Oliver Upton <oupton@kernel.org>,
	Ackerley Tng <ackerleytng@google.com>,
	Josh Hilke <jrhilke@google.com>,
	Wu Fei <wu.fei9@sanechips.com.cn>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Leonardo Bras <leo.bras@arm.com>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] KVM: selftests: Add support for dirty-ring on dirty_log_perf_test
Date: Mon, 16 Nov 2026 11:15:11 +0000
Message-ID: <avrlvzq4LWrWeScS@LeoBrasDK>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261009130054.3312154-2-leo.bras@arm.com>
References: <20261009130054.3312154-2-leo.bras@arm.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Oct 09, 2026 at 02:00:45PM +0100, Leonardo Bras wrote:
> Add support to dirty-ring on dirty_log_perf_test, so we can measure
> performance differences when we change / improve the mechanism.
> 
> One big change in this set is that dirty-ring needs to be enabled
> after the VM was created, but before any cpu is created, so for that,
> I made a few changes on memstress so it can actually take dirty-ring
> size as a parameter for VM creation. (Patches #1 & #2)
> 
> Also added some checks in dirty-ring enable, so an error message on
> ring size is more informative.
> 
> Please provide feedback :)
> 
> Thanks!
> Leo
 
Hello,
Just a friendly ping on this series.
It still applies cleanly on v7.4-rc3. 

Please let me know if you have any feedback or if anything needs to be 
adjusted.


Thanks,
Leo
