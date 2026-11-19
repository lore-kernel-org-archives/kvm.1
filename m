Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795092195;
	b=AIEPCM6Nwz99VwTQKs17j0uet54sTKzVE9tdyaiN+FQtWryC1oEqrDza27DNIFS3IUDZ
	 R7I8TxZZG0P9bmDD4rfks1OfmyMRCakm0LywpJxW+KURAGi0NX3nMrH70Sl3vSRIldZCP
	 sIFpPSYOh21spdXwAzFr1dWH8tCf47z/T15bckquzmd76M0Jd/eJ3gn+w6XCqvVsub24V
	 5YbA4wHvdp0E6R7tq/rLti+ilCv4DttjJTs+a+K3XPZ62uXGcYUPhXfagUojBQRI8nNUw
	 FtOoRQaLU7Dp6sD2d+lR2X3l415Z/Zgo+WuidzPIVBDviWWTX0gtZiQ07s1yoJKEX9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795092195;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding;
	bh=VTjupcSpYzzr9KNGDPSXl6giQ6oG/6POX/XFEkVBgNI=;
	b=BP7fHZPUMFfxwQnVEKoEsERcTNS3r97eYXxuAWJnWdAA16JG38SfQZzCrKEZt/Qvt4Ry
	 kJiBc8MZNkFe3jqCtyIQw78ApMfFNT3TAhWnMw5XPu6et0ZUsUJzL+cdiqquraP0EkLwt
	 +/qW9Z5IzwQfHbu6Va4Q8aJjSnhblNb9Frkb8cWCCuSAM2L1E6jEyL6lH/5y0vYT/+Prc
	 0CUCtvGAgH5QlUQx344aZULoXO32soRSXjD324uVxpwTS1lXZdvnTIxTiSj4bhKjr6nDF
	 W+ktzHwUYK/0FQ4NRiYpiVZBDTsV3S+EZSit/5IfLgTqRrEq68/z3YNQNqSZiMGYCyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=JNIKzsA7;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128B3606A32A;
	Thu, 19 Nov 2026 12:43:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 128B3606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=JNIKzsA7
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 832531575;
	Thu, 19 Nov 2026 04:43:11 -0800 (PST)
Received: from LeoBrasDK.cambridge.arm.com (LeoBrasDK.cambridge.arm.com [10.2.212.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A714B3F673;
	Thu, 19 Nov 2026 04:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795092194; bh=za+fnZdRLjQ9PKrb6uwhGlDBXDw9fZ4MnLIhFVL6BzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JNIKzsA7khRH6ciHshwEpQaxgEJx0ylRea4TEFqPmd2mz2FADg3u7HLX9Loa7iP+7
	 UQwv+5Xl+3qKHLc2EmOSUs0W+UVmpR3HsUt/P0iTQmpgt3fMLzOz6tCXS0A9rJ+n4R
	 oUYw6W1zWmGp/2AEgQQoUurRtb131TZ3eO/Vcd/M=
From: Leonardo Bras <leo.bras@arm.com>
To: Colton Lewis <coltonlewis@google.com>
Cc: Leonardo Bras <leo.bras@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] KVM: arm64: selftests: Verify HCR_EL2.NV1 is RES0 when E2H0 is NI_NV1
Date: Thu, 19 Nov 2026 12:43:10 +0000
Message-ID: <av7u3vWHUBzcgSSg@LeoBrasDK>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118203625.743428-3-coltonlewis@google.com>
References: <20261118203625.743428-1-coltonlewis@google.com> <20261118203625.743428-3-coltonlewis@google.com>
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

On Wed, Nov 18, 2026 at 08:36:25PM +0000, Colton Lewis wrote:
> In a VHE-only EL2 guest (KVM_ARM_VCPU_HAS_EL2 without
> KVM_ARM_VCPU_HAS_EL2_E2H0), KVM advertises ID_AA64MMFR4_EL1.E2H0 as
> NI_NV1, making HCR_EL2.E2H RES1 and HCR_EL2.NV1 RES0.
> 
> Extend hello_el2 to attempt clearing HCR_EL2.E2H and setting HCR_EL2.NV1
> from userspace via KVM_SET_ONE_REG, verifying that HCR_EL2.E2H remains
> RES1 and HCR_EL2.NV1 is masked to RES0. Add a comment explaining why the
> check is performed from userspace rather than inside the guest.
> 
> Signed-off-by: Colton Lewis <coltonlewis@google.com>
> ---
>  tools/testing/selftests/kvm/arm64/hello_el2.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/arm64/hello_el2.c b/tools/testing/selftests/kvm/arm64/hello_el2.c
> index bbe6862c6ab16..3bd3596f5fb1e 100644
> --- a/tools/testing/selftests/kvm/arm64/hello_el2.c
> +++ b/tools/testing/selftests/kvm/arm64/hello_el2.c
> @@ -45,6 +45,7 @@ int main(void)
>  	struct kvm_vcpu *vcpu;
>  	struct kvm_vm *vm;
>  	struct ucall uc;
> +	u64 hcr;
>  
>  	TEST_REQUIRE(kvm_check_cap(KVM_CAP_ARM_EL2));
>  
> @@ -66,6 +67,20 @@ int main(void)
>  		TEST_FAIL("Unhandled ucall: %ld\n", uc.cmd);
>  	}
>  
> +	/*
> +	 * Verify RES0/RES1 enforcement from userspace rather than inside
> +	 * the guest. From the guest's perspective RESx bits may be
> +	 * stateful (reading back as written) even though their value is
> +	 * ignored, whereas KVM_SET_ONE_REG applies the effective masks
> +	 * directly.
> +	 */
> +	hcr = vcpu_get_reg(vcpu, KVM_ARM64_SYS_REG(SYS_HCR_EL2));
> +	vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_HCR_EL2),
> +		     (hcr & ~HCR_EL2_E2H) | HCR_EL2_NV1);
> +	hcr = vcpu_get_reg(vcpu, KVM_ARM64_SYS_REG(SYS_HCR_EL2));
> +	TEST_ASSERT(hcr & HCR_EL2_E2H, "HCR_EL2.E2H should be RES1");
> +	TEST_ASSERT(!(hcr & HCR_EL2_NV1), "HCR_EL2.NV1 should be RES0");
> +
>  	kvm_vm_free(vm);
>  	return 0;
>  }
> -- 
> 2.56.1.750.gf70dc682cf-goog
> 


The VMM tries to set NV1 and clean E2H, and it should not work.

Current kernel should pass this test, as vcpu_set_reg() will call a 
KVM_SET_ONE_REG ioctl, going down to __vcpu_assign_sys_reg() which will, 
given vcpu_has_nv(), will apply RES0 to NV1 (patch #1) and RES1 to E2H, as 
per this line:

NEEDS_FEAT_FLAG(HCR_EL2_E2H, RES1_WHEN_E2H1 | FORCE_RESx)

FWIW:
Reviewed-by: Leonardo Bras <leo.bras@arm.com>

Thanks!
Leo
