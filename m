Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CAC3BB40
	for <kvm@vger.kernel.org>; Tue, 27 Jan 2026 16:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769532354; cv=none; b=Te6UFEWwSCrfIf6EyzVxeW8H2e6larxiCLUg8SOJfBPVLRA8IPfj+88udP2XNcgJ3ViLcui3xOl0FAM51+fl92qVKXYSVC7RyXCAYF03xkz4wZ9Tr7z/oYcpWKiCjVeVRAZWESpwjQmXMHa79fdCGrs2COkgSPposVQ9oUVa5gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769532354; c=relaxed/simple;
	bh=WV0jNIybQSfsNZI2PdZ3BdF9K7uAX3CV1InWowP4Ou4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbV+XlLo1+TlTibfWtcfz1UQrf5BaBPYjyw4Oq32wB5ZTPEE0F2Hi0LLYYqzYvCdI1SQbvUmSogaKzcmfS4Mfa2LWQhNouEe2/VgNwqKMEFa7WYoiYsiHxuTmTrtNrJKRDkrKI/8DLDfos8MvZOwhn960Sea7Q7X3OpYYsa6inA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BYBcHzsn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BYBcHzsn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769532352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=le+QIA3MVLjFV6Hy72PJU2Cloq74C4eosBPg35am3tw=;
	b=BYBcHzsnIp4f2B9rt2O/Bzvn6buSfiU7SGSyzWlsEf1/g6dRTQIqii3phL/3nzPQzYegkk
	Sbg9NDKGb+gGg7yTXh0h7KHKPWltJl7VnOO0OYKxS8/9Url1e0ZMX6dYiLORUxlSmFuY/V
	Gw/z2l7caQGY7PHVVlGLgdh6RTKzlK8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-T9i8XDmWPC2EQ02o1nSP6w-1; Tue,
 27 Jan 2026 11:45:44 -0500
X-MC-Unique: T9i8XDmWPC2EQ02o1nSP6w-1
X-Mimecast-MFC-AGG-ID: T9i8XDmWPC2EQ02o1nSP6w_1769532341
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 54DFD180035D;
	Tue, 27 Jan 2026 16:45:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.34.28])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D27DD30001A2;
	Tue, 27 Jan 2026 16:45:38 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 5F9B9180009C; Tue, 27 Jan 2026 17:45:36 +0100 (CET)
Date: Tue, 27 Jan 2026 17:45:36 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Peter Maydell <peter.maydell@linaro.org>, Marcelo Tosatti <mtosatti@redhat.com>, 
	Song Gao <gaosong@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Chinmay Rath <rathc@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, 
	qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
	qemu-s390x@nongnu.org
Subject: Re: [PATCH v3 05/33] accel/kvm: add changes required to support KVM
 VM file descriptor change
Message-ID: <aXjrS7uZGNwCIX3c@sirius.home.kraxel.org>
References: <20260127051612.219475-1-anisinha@redhat.com>
 <20260127051612.219475-6-anisinha@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127051612.219475-6-anisinha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -1569,6 +1569,16 @@ void kvm_arch_init_irq_routing(KVMState *s)
>  {
>  }
>  
> +int kvm_arch_on_vmfd_change(MachineState *ms, KVMState *s)
> +{
> +    abort();
> +}
> +
> +bool kvm_arch_supports_vmfd_change(void)
> +{
> +    return false;
> +}
> +

Put that into stubs/kvm.c ?  Should avoid the duplication for all archs
which do not support vmfd_change.

take care,
  Gerd

