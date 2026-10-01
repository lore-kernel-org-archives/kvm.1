Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93FB5208D3;
	Thu,  1 Oct 2026 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865624; cv=none; b=AZynMgQzz+LMH2lWJfDg4oCcRjSCoi5GR1RpcB6XuAdsu+gXFn9puSYDh8d2bu5auSPg8oxi61/psulWKbK9fatDpAryfkI8+J4LIW2TUdd0hOkPCgbHF7MR38usgFoCaKvDh4tF5/X+8kvfmMyVxoAodJRW3OqBiu3UZ9UZAUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865624; c=relaxed/simple;
	bh=E1InJ2llnSeZQ/eSTl6l3T94mAZ702T9aQ5sBsYQImI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=LJR0K7h9JYOVHB8Qtva7BJ6P/6bviUvwl6/YCuGWK5juqZ1w/CGCjDubrZSC7r1qC5CMUOx7g5oHB71/PaQHTLSTzz8eP2Y9vp26xDsX4t7I3Xx5Ym+zzjYP+JcTivFZfNsynFCj0JHvf3rkzRSvEmSAO0FG5dBQZlodUV/U0gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sFhzi1ha; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sFhzi1ha"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 742AA497;
	Thu,  1 Oct 2026 07:40:09 -0700 (PDT)
Received: from LeoBrasDK.cambridge.arm.com (LeoBrasDK.cambridge.arm.com [10.2.212.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F24893F85F;
	Thu,  1 Oct 2026 07:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790865612; bh=E1InJ2llnSeZQ/eSTl6l3T94mAZ702T9aQ5sBsYQImI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sFhzi1haYixfTtkJw6O9QcZceOSjpOoy7bBBCaqIl0Vb8lOCnR3RyL//lixYP5SMy
	 K/PUjH0FR0UQ8Y2Y1uLcd3PG3THVRn2Bmz4WQCSt0OJv5oTi+tKtAAltnCi3Hw9oQr
	 vbfE5tACUd8NnQhOFQxc/Q02iSyR2UGSg2sp231M=
From: Leonardo Bras <leo.bras@arm.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Leonardo Bras <leo.bras@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Josh Hilke <jrhilke@google.com>,
	Oliver Upton <oupton@kernel.org>,
	Wu Fei <wu.fei9@sanechips.com.cn>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] KVM: selftests: memstress: Add option to enable dirty-ring on VM creation
Date: Thu,  1 Oct 2026 15:40:01 +0100
Message-ID: <ar5wwUsGJc2l8r-W@LeoBrasDK>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <ar1TItRR7o789i6_@google.com>
References: <20260929113711.2064390-1-leo.bras@arm.com> <20260929113711.2064390-2-leo.bras@arm.com> <ar1TItRR7o789i6_@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Sep 30, 2026 at 11:21:22AM -0700, Sean Christopherson wrote:
> On Tue, Sep 29, 2026, Leonardo Bras wrote:
> > Dirty-ring should be enabled after the VM is created, but before the
> > creation of any cpu. To to so, add an option on memstress_create_vm() that
> > takes dirty-ring size, and enables it at the correct moment.
> > 
> > This required a new function memstress_vm_create_with_vcpus() to be
> > created based on the previously used __vm_create_with_vcpus();
> 
> Rather than pile on more params, if I ask really nicely, would you rework
> memstress_create_vm() and friends APIs to take a "struct memstress_params"?
> Except for dirty_log_page_splitting_test.c, all of the memstress tests already
> use a struct, i.e. while tedious, it should be straightforward and won't put
> undue burden on tests (which is why the core VM creation APIs don't take a struct
> of params).
> 
> Then it will be easier to extend memstress in the future, and I suspect the
> existing code will come out cleaner as well.  E.g. dirty_log_perf_test.c stores
> nr_vcpus as a global, despite it being fully contained by main() => run_test(),
> right alongside the test params...


Hi Sean, thanks for reviewing!

Sure, will convert it to use a struct as well :)

Thanks!
Leo
