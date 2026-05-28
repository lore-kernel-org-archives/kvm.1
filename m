Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246FF3AF65B;
	Thu, 28 May 2026 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779984164; cv=none; b=O0aRhJ/HfVZrdivIciFhCX5WDzQtCw/CQKO4kwtc8pzzh6SPj+fc9Roo9pY+dKal5OTI+RMD5VW3O8P8f6l0tyKXN3f1Qq2iZVe/SBjfJwB+HaUHPYJY7CwdJJRkekCtaQYn1MqGbohxJOL2o5lyOUKmbmksvX1g8lKmbnlqKoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779984164; c=relaxed/simple;
	bh=+3NZq5dyM0nlToai4ZJnLVK01+vkOLwJqQPh16PmDi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPnzOnPiLOnpMTvUaddt9n+1YD9JU3D+s4LDf/YO6qiMV9QYEU8M/nVoFU9q9OYFX0y98dQu7F+fGSZ/IAj2HuhcV2pm9aF/JnvZXuNFh/0zAUGiILyUAG2hvqA73Ntek2reOY7ewFg3LObbmYGS+BjEmy+f2pdo3shto/gsbQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=AdVSrkJg; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="AdVSrkJg"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B3E51516;
	Thu, 28 May 2026 09:02:36 -0700 (PDT)
Received: from thinkpad-e142931.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65DB83F632;
	Thu, 28 May 2026 09:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779984161; bh=+3NZq5dyM0nlToai4ZJnLVK01+vkOLwJqQPh16PmDi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AdVSrkJgUSXeylTFkCIm0mQxisd9y46JeZF7B3NwfLleUGnxVsprAjTCoxNnqgGT1
	 +GeybXY1oOSxQ1TFAo8hPvUlyb8DOi6eEaWL5XWPZI4PUT6E/cfrGXD7wvQvRkNjuf
	 so/Uqn5S9Lzi/YdIgjvxWnfGmh91Dnm2B4EJPG+o=
Date: Thu, 28 May 2026 17:02:30 +0100
From: Wei-Lin Chang <weilin.chang@arm.com>
To: Itaru Kitayama <itaru.kitayama@fujitsu.com>
Cc: catalin.marinas@arm.com, joey.gouly@arm.com, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, maz@kernel.org, 
	oupton@kernel.org, pbonzini@redhat.com, shuah@kernel.org, suzuki.poulose@arm.com, 
	will@kernel.org, yuzenghui@huawei.com
Subject: Re: [PATCH] KVM: selftest: arm64: Run shadow_stage2 varying guest
 modes
Message-ID: <r2dui45c3mp2qzns6dplqj6pfima5tq7huhvbwus225xamuccn@aw753ihdimz5>
References: <20260516183003.799058-6-weilin.chang@arm.com>
 <20260528045930.450339-1-itaru.kitayama@fujitsu.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528045930.450339-1-itaru.kitayama@fujitsu.com>

Hi Itaru,

On Thu, May 28, 2026 at 01:59:30PM +0900, Itaru Kitayama wrote:
> Refactor main() to use for_each_guest_mode() helper to create
> a single VCPU VM with a guest mode ID.
> 
> Signed-off-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
> ---
>  tools/testing/selftests/kvm/arm64/shadow_stage2.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/arm64/shadow_stage2.c b/tools/testing/selftests/kvm/arm64/shadow_stage2.c
> index 5bce55abdea7..05acca22eafe 100644
> --- a/tools/testing/selftests/kvm/arm64/shadow_stage2.c
> +++ b/tools/testing/selftests/kvm/arm64/shadow_stage2.c
> @@ -105,7 +105,7 @@ static void guest_code(void)
>  	GUEST_DONE();
>  }
>  
> -int main(void)
> +int run_test(enum vm_guest_mode mode, void *unused)
>  {
>  	struct kvm_vcpu_init init;
>  	struct kvm_vcpu *vcpu;
> @@ -114,7 +114,8 @@ int main(void)
>  	gpa_t gpa;
>  
>  	TEST_REQUIRE(kvm_check_cap(KVM_CAP_ARM_EL2));
> -	vm = vm_create(1);
> +	vm = __vm_create(VM_SHAPE(mode), 1, 0);
> +
>  
>  	kvm_get_default_vcpu_target(vm, &init);
>  	init.features[0] |= BIT(KVM_ARM_VCPU_HAS_EL2);
> @@ -163,3 +164,7 @@ int main(void)
>  	kvm_vm_free(vm);
>  	return 0;
>  }
> +
> +int main(void) {
> +	for_each_guest_mode(run_test, NULL);
> +}
> -- 
> 2.43.0
> 

Thanks! I think this is valuable.
I can add your patch into the next version if you don't mind?

Thanks,
Wei-Lin Chang
