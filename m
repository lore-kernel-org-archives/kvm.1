Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE873346BE;
	Thu, 28 May 2026 22:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780006459; cv=none; b=k+FIuNl8SPsoTdOit2m/1duFEKYL10mUdz06eU8M49IsoHEo6w8Nz7xnHpDS+BHyfruVqg3lB9mtj9UFJ0vlOZSMVwE4vNzCjTyqpZHApNw0Gl1tYsWrDqYvDzH3AWS1aZkXq5Qph8v3n1Si6PdIjtnJU3+losVTDT7t/BCyCEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780006459; c=relaxed/simple;
	bh=FWIBzXhLkf8QASpXt/e0kLaIXQ8j42MXyINrPuFKZF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nS1BRXZkQmpVxUH9SzFQ2o6oodcTfUOSbce93by0jnoCQH434w39u1vxi+qGmNnjFobSlLk6o02wxWhn5eSppU3SVDTVcWUT8wsXxUskAnm7YFAVpH8yBzlHmlac+TH3LBsooBsxhyIVurpxVCJKh38prNORORk5dOO4/PhoEEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=UbDmhZgv; arc=none smtp.client-ip=139.138.36.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="UbDmhZgv"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1780006457; x=1811542457;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FWIBzXhLkf8QASpXt/e0kLaIXQ8j42MXyINrPuFKZF0=;
  b=UbDmhZgvL0O+JZB1wS+gBfvXh0pv41RQKw7qmlR0syFXz+EcuJQPmhzq
   Kh5YYtyNF5c2nyrx74Kq08SpIcLq0SDkbUCi7HP0qo2VpD5svLGGdooLY
   oMZWfjk9M+DQ2Tp61J6Auq27zIGulBCqCHGEiCY3t1qcxR+PvMiOPVZQu
   g9I3WQaOmyC78trFvVY5RS3Ztz/XZRpSth8ROHqK317h7GGIK0lC3MENR
   d4WW8gQLn6XhTIwMQNUrZIZohfaFQF3+0puKB8mBn5nyRNQqA1qVOK2h+
   5xefAUrwU/zGsX/EAeFjQzDEylnVdpCw6uvxpNrunRSYu3j0hkwlvWI0d
   Q==;
X-CSE-ConnectionGUID: HsdRsbaiQbSrc9Om8Y1f4Q==
X-CSE-MsgGUID: L9tAxflHTEasNOg6SR6oSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="229565395"
X-IronPort-AV: E=Sophos;i="6.24,174,1774278000"; 
   d="scan'208";a="229565395"
Received: from gmgwnl01.global.fujitsu.com (HELO mgmgwnl01.global.fujitsu.com) ([52.143.17.124])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 07:14:15 +0900
Received: from az2nlsmgm1.o.css.fujitsu.com (unknown [10.150.26.203])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mgmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id 991912BB4;
	Thu, 28 May 2026 22:14:15 +0000 (UTC)
Received: from az2nlsmom1.o.css.fujitsu.com (unknown [10.150.26.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm1.o.css.fujitsu.com (Postfix) with ESMTPS id 4F35DC19F6B;
	Thu, 28 May 2026 22:14:15 +0000 (UTC)
Received: from sm-arm-grace07 (unknown [10.124.178.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmom1.o.css.fujitsu.com (Postfix) with ESMTPS id 1348B82C235;
	Thu, 28 May 2026 22:14:09 +0000 (UTC)
Date: Fri, 29 May 2026 07:14:07 +0900
From: Itaru Kitayama <itaru.kitayama@fujitsu.com>
To: Wei-Lin Chang <weilin.chang@arm.com>
Cc: catalin.marinas@arm.com, joey.gouly@arm.com, kvm@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	maz@kernel.org, oupton@kernel.org, pbonzini@redhat.com,
	shuah@kernel.org, suzuki.poulose@arm.com, will@kernel.org,
	yuzenghui@huawei.com
Subject: Re: [PATCH] KVM: selftest: arm64: Run shadow_stage2 varying guest
 modes
Message-ID: <ahi-L_HQXkxPuCYL@sm-arm-grace07>
References: <20260516183003.799058-6-weilin.chang@arm.com>
 <20260528045930.450339-1-itaru.kitayama@fujitsu.com>
 <r2dui45c3mp2qzns6dplqj6pfima5tq7huhvbwus225xamuccn@aw753ihdimz5>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <r2dui45c3mp2qzns6dplqj6pfima5tq7huhvbwus225xamuccn@aw753ihdimz5>

On Thu, May 28, 2026 at 05:02:30PM +0100, Wei-Lin Chang wrote:
> Hi Itaru,
> 
> On Thu, May 28, 2026 at 01:59:30PM +0900, Itaru Kitayama wrote:
> > Refactor main() to use for_each_guest_mode() helper to create
> > a single VCPU VM with a guest mode ID.
> > 
> > Signed-off-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
> > ---
> >  tools/testing/selftests/kvm/arm64/shadow_stage2.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/kvm/arm64/shadow_stage2.c b/tools/testing/selftests/kvm/arm64/shadow_stage2.c
> > index 5bce55abdea7..05acca22eafe 100644
> > --- a/tools/testing/selftests/kvm/arm64/shadow_stage2.c
> > +++ b/tools/testing/selftests/kvm/arm64/shadow_stage2.c
> > @@ -105,7 +105,7 @@ static void guest_code(void)
> >  	GUEST_DONE();
> >  }
> >  
> > -int main(void)
> > +int run_test(enum vm_guest_mode mode, void *unused)
> >  {
> >  	struct kvm_vcpu_init init;
> >  	struct kvm_vcpu *vcpu;
> > @@ -114,7 +114,8 @@ int main(void)
> >  	gpa_t gpa;
> >  
> >  	TEST_REQUIRE(kvm_check_cap(KVM_CAP_ARM_EL2));
> > -	vm = vm_create(1);
> > +	vm = __vm_create(VM_SHAPE(mode), 1, 0);
> > +
> >  
> >  	kvm_get_default_vcpu_target(vm, &init);
> >  	init.features[0] |= BIT(KVM_ARM_VCPU_HAS_EL2);
> > @@ -163,3 +164,7 @@ int main(void)
> >  	kvm_vm_free(vm);
> >  	return 0;
> >  }
> > +
> > +int main(void) {
> > +	for_each_guest_mode(run_test, NULL);
> > +}
> > -- 
> > 2.43.0
> > 
> 
> Thanks! I think this is valuable.
> I can add your patch into the next version if you don't mind?

No, I would not, for the record your test rans with all the available guest
modes without an issue (ie ended DONE!) on QEMU in tcg mode.

Thanks,
Itaru.

> 
> Thanks,
> Wei-Lin Chang
