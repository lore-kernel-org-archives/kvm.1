Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881058;
	b=yvnyZF7gKOPxBygFxs9J1Ro6Y0OW6O0lIq+thZbGkAdFM4SosfK5jJ4A9xDHMAL7vbCq
	 Fbl6rQKADiLTXzElvbF7YNdDs6FD+U6ceByB2bdIUCv9GY4Zmy8TdIvHcUSNqETo+Km9a
	 jIdlYLM91MNGenoUMxh7bZP2iIRB+V7NUVXRcf0H1RQ/dw43Ulc3oYSjTV013pC44n7xf
	 B37ynZCTfxVOsSGFvecd3MWpMXbVxJzMjMWfNl0XrM5paEPI0MMBiOP5qOnVqPSnH8Ir7
	 cMwZEn7b13N1iWLC1ZWeZuQHv7NT7xiePQdPt7TXHeJ3QEzsa4vNgzX84IkDFvXE1bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881058;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=ShM/LzYh15H1VmyFk0yd5n30U2OKlMZRrk7dfYFeEYg=;
	b=wMlx1RaMQcOpiVh1T7EX7Y69P4d5LIeiQ2VrST43VERBGwLcEwyx1V8gjBaIMAGfpvjO
	 7w+Soy5w6q2+IdvVhMs+5rr1Kz8ki1JzWDyQlha+e/QR3Aq1a3ev3hI8TYvA+WQ7CoMgk
	 i714iZh42khAmFX6LPlkwb+H7/sjLK2W139zHub0S8ZsARna92v5wtdU0Jjr4kHCrAtaC
	 ha6miSBeWZLIeQU1Jn2GSBGsS/ad950nddlRaLm9QzFN85BZJm8PEUdBEYmXgmVlodc2n
	 o1jp3AQ60YrKE+v/ajXca0Os6MUyC3ki0W1rGX47w8VckazH0dwgSfpVfRzawSvWckA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=C49j3ekR;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3893A6083612;
	Thu,  5 Nov 2026 12:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3893A6083612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=C49j3ekR
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FE3B1E8D;
	Thu,  5 Nov 2026 04:17:33 -0800 (PST)
Received: from e143914.arm.com (e143914.arm.com [10.2.213.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA9E03F673;
	Thu,  5 Nov 2026 04:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793881056; bh=j+lMJnSylQrD0+1OcivdSJ9GghFhWY5EWMq7YDes8RE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C49j3ekRRJi4RIZjd+tLIQL0aAmav4TKv+fDqpVmVSA7o8pP12o3qsbmQl66Eb4FY
	 tQI06CfIEa3l1jEqjC3YJhdwOtLwH3CynzRnTXSLrkf7RMRpk6qz0ijy7jhJ4s4dKt
	 jGgdNxarCNp7z1j7cgVPoLV+lKnkKnPIz2rEzrhI=
Date: Thu, 5 Nov 2026 12:16:09 +0000
From: Joey Gouly <joey.gouly@arm.com>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
	Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>, Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Quentin Perret <qperret@google.com>, Fuad Tabba <tabba@google.com>,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/16] KVM: selftests: Allow arm64 tests to create
 protected VMs
Message-ID: <auxziQ6yLOW5dhKv@e143914.arm.com>
References: <20261104084842.132944-1-fuad.tabba@linux.dev>
 <20261104084842.132944-3-fuad.tabba@linux.dev>
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
In-Reply-To: <20261104084842.132944-3-fuad.tabba@linux.dev>

On Wed, Nov 04, 2026 at 08:48:28AM +0000, Fuad Tabba wrote:
> On arm64, the VM type passed to KVM_CREATE_VM carries the IPA size,
> which the selftest library fills in. The library rejects any type a test
> provides in vm_shape.type. A protected VM is created by setting
> KVM_VM_TYPE_ARM_PROTECTED in that type, so a test can't create one.
> 
> Accept KVM_VM_TYPE_ARM_PROTECTED from the test, and add the IPA size to
> it as for any other VM.
> 
> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>

Similar to what I did for realms locally, and will have to expand to
support KVM_VM_TYPE_ARM_REALM.

Reviewed-by: Joey Gouly <joey.gouly@arm.com>

> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index d42e201eba763..96c1e70dba3d3 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -400,9 +400,10 @@ struct kvm_vm *____vm_create(struct vm_shape shape)
>  	}
>  
>  #ifdef __aarch64__
> -	TEST_ASSERT(!vm->type, "ARM doesn't support test-provided types");
> +	TEST_ASSERT(!(vm->type & ~KVM_VM_TYPE_ARM_PROTECTED),
> +		    "ARM supports only KVM_VM_TYPE_ARM_PROTECTED as a test-provided type");
>  	if (vm->pa_bits != 40)
> -		vm->type = KVM_VM_TYPE_ARM_IPA_SIZE(vm->pa_bits);
> +		vm->type |= KVM_VM_TYPE_ARM_IPA_SIZE(vm->pa_bits);
>  #endif
>  
>  	vm_open(vm);
> -- 
> 2.47.3
> 
