Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B10E3CAA55
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 20:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778617653; cv=none; b=k3Uk+jKKP0p//C1QbqXpZzpSt2WJH6xSzIFz4Eg6x121YGAuBpZ8cJCoFSp7aQCQBJpiOssYWXjmtnNCC48uReaVnt7oXlJlxLylLDd7ezi7z2uY0auh0NFSoAY2d6f3pMWSm6KTQg6a2xMSdr2wwAVqjU0v5F9nwXVYZZFHLgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778617653; c=relaxed/simple;
	bh=cTif80+r+YVIl8ZsW9z43wZoHlkvGxwjPTmZdA20GKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e/6owaVL0fpG6mv1CUvA0WUyvYyN2Vl+jhZ55dkRP7LX0YoSzLD/JeUgm/0kvZ75EnDgzBbZ6bduP3mtZncwUQrbMGv7EmeDMWwdMRm4p9zkX54davDpIe2tV2y3osN6/RuLy9zXL7jP32yr+52cQH/bGg98zm1rrFrYwEIEYqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cNMpUS+A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cNMpUS+A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778617651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SGokJ9C9SXjXNgjc7ZtjXJtRe0rrJrSgOqhmPGMGHL0=;
	b=cNMpUS+A1FvhgzEu4xj9uHML5CE/e0EBhco1g4Us30nK7FxnnpQMvAXSEVSPAD+4Mf1zfX
	G8Kx5NWLmdvK6jt2ydiQKQ/RgySHAadmfiFtb+Hc4bdcGF2gz5ht5zd2qrv1ozSbdWIvo8
	rqhhibSbxyXFH+ylM9EqlFlzqD3MS4Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-NX35Y5qpOBaMNt0Tkzs1gA-1; Tue,
 12 May 2026 16:27:28 -0400
X-MC-Unique: NX35Y5qpOBaMNt0Tkzs1gA-1
X-Mimecast-MFC-AGG-ID: NX35Y5qpOBaMNt0Tkzs1gA_1778617647
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C47D1956094;
	Tue, 12 May 2026 20:27:27 +0000 (UTC)
Received: from [10.44.48.5] (unknown [10.44.48.5])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B2DB119560A2;
	Tue, 12 May 2026 20:27:25 +0000 (UTC)
Message-ID: <0b5f6e6a-2fa6-43c5-93c5-f958a652040c@redhat.com>
Date: Tue, 12 May 2026 22:27:23 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: selftests: Ensure gmem file sizes are multiple of
 host page size
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zenghui Yu <zenghui.yu@linux.dev>
References: <20260512155634.772602-1-seanjc@google.com>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260512155634.772602-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 5/12/26 17:56, Sean Christopherson wrote:
> When creating a guest_memfd file and associated memslot to validate shared
> guest memory, size the file+memslot to the maximum of the host or guest
> page size.  Attempting to allocate a single guest page will fail if the
> host page size is greater than the guest page size, as KVM requires that
> the size of memslots and guest_memfd files are a multiple of the host page
> size.
> 
> For simplicity, verify the entire file can be shared between guest and host,
> e.g. instead of trying to validate "partial" mappings.
> 
> Fixes: 42188667be38 ("KVM: selftests: Add guest_memfd testcase to fault-in on !mmap()'d memory")
> Reported-by: Zenghui Yu <zenghui.yu@linux.dev>
> Closes: https://lore.kernel.org/all/0064952b-048c-455d-ad89-e27e5cb82591@linux.dev
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Queued, thanks.

Paolo

> ---
>   tools/testing/selftests/kvm/guest_memfd_test.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
> index d6528c6f5e03..253e748c1d4a 100644
> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
> @@ -510,7 +510,12 @@ static void test_guest_memfd_guest(void)
>   		    "Default VM type should support INIT_SHARED, supported flags = 0x%x",
>   		    vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_FLAGS));
>   
> -	size = vm->page_size;
> +	/*
> +	 * Use the max of the host or guest page size for all operations, as
> +	 * KVM requires guest_memfd files and memslots to be sized to multiples
> +	 * of the host page size.
> +	 */
> +	size = max_t(size_t, vm->page_size, page_size);
>   	fd = vm_create_guest_memfd(vm, size, GUEST_MEMFD_FLAG_MMAP |
>   					     GUEST_MEMFD_FLAG_INIT_SHARED);
>   	vm_set_user_memory_region2(vm, slot, KVM_MEM_GUEST_MEMFD, gpa, size, NULL, fd, 0);
> @@ -519,7 +524,7 @@ static void test_guest_memfd_guest(void)
>   	memset(mem, 0xaa, size);
>   	kvm_munmap(mem, size);
>   
> -	virt_pg_map(vm, gpa, gpa);
> +	virt_map(vm, gpa, gpa, size / vm->page_size);
>   	vcpu_args_set(vcpu, 2, gpa, size);
>   	vcpu_run(vcpu);
>   
> 
> base-commit: 6d35786de28116ecf78797a62b84e6bf3c45aa5a

