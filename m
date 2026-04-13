Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD3829E11A
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 11:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776079946; cv=none; b=Pz2h95GOnhbTs5MwBWG/B46AlLS3iOYhm4TGIcd+C0Rtn99k7sYI6PF+F/17XfJkJho7d7QXTCbU6apoYSxP2crThtrz6wYdPjgXH9q55wZ6uiKeNU66gXeNTU1pTVSdA3WRFMSwAdJDTZwOlVB12uzUCwD4rUm5EQ/ZUXdGVw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776079946; c=relaxed/simple;
	bh=PHP0Q/hn3C9fZ+SGZsOcZ8JhCBeR1GddGJlsDIvOGX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aa8fFUTwAebrhOn0M2jRcibVcFyHFtkfSmFx4Fqm0pzjAzsO7sgPF/XGJjrqeHSAxB7uRdDhaV/F4EATcxuOlbmJVxZmvaPIL4dlQn3OWRoMajkpKggxaCg1zuwKj5MRA21K/Gpn0UHL2e7qmzwwMXsGNTWX76trxWYmJJxJcEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jHTWzhpJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHTWzhpJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776079944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZiiuLKPMghlNGFyXtqChN8Tx7/OQ7e3cZ6Zzt9Y5S5E=;
	b=jHTWzhpJTg02k+obqwdV6xLYoDw4s46DYXE1Od/VZAnXN+6Ps598lUgs1GXIUJxgcgF7Ut
	cxxGzxa7C15K7eVt1HRIW7HWiRgIXLTZ+vRby8F2L2LHys+/IQvdiYv/3gtxW5NbWWybyh
	HRQsQgGHXDYUoIQu7cyKH6qCm+az5Dk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-AokT6skCNsCXAvkUMmmLdQ-1; Mon,
 13 Apr 2026 07:32:18 -0400
X-MC-Unique: AokT6skCNsCXAvkUMmmLdQ-1
X-Mimecast-MFC-AGG-ID: AokT6skCNsCXAvkUMmmLdQ_1776079937
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 85078195609F;
	Mon, 13 Apr 2026 11:32:17 +0000 (UTC)
Received: from [10.44.50.126] (unknown [10.44.50.126])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ACE6C180049F;
	Mon, 13 Apr 2026 11:32:15 +0000 (UTC)
Message-ID: <279763ec-438a-46a2-b2fd-e5b445ab0160@redhat.com>
Date: Mon, 13 Apr 2026 13:32:12 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] VFIO: take reference to the KVM module
To: Sean Christopherson <seanjc@google.com>
Cc: "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>,
 kvm <kvm@vger.kernel.org>, Steffen Eiden <seiden@linux.ibm.com>,
 Alex Williamson <alex.williamson@nvidia.com>,
 Dan Williams <dan.j.williams@intel.com>
References: <20260407180107.1603697-1-pbonzini@redhat.com>
 <20260407180107.1603697-2-pbonzini@redhat.com> <adf29Rn7q9Db0hxc@google.com>
 <CABgObfZQ8kcdfiaUyGi6AcZErJztEmcdTcLwo946qtXfUwDM4g@mail.gmail.com>
 <adkFk3ZN4HJtpLA3@google.com>
 <CABgObfaE2g30D789zK1N8xMfcAzPG8gz8MPERQ+DYxd7Soi-Gw@mail.gmail.com>
 <adka_L18z24zsQpc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <adka_L18z24zsQpc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 4/10/26 17:45, Sean Christopherson wrote:
> On Fri, Apr 10, 2026, Paolo Bonzini wrote:
>> On Fri, Apr 10, 2026 at 4:13 PM Sean Christopherson <seanjc@google.com> wrote:
>>>
>>> +Dan
>>>> We could get rid of the reference count completely (get_file() as a
>>>> replacement for kvm_get_kvm(), get_file_active() as a replacement for
>>>> kvm_get_kvm_safe()). struct kvm would need to add a back pointer from
>>>> struct kvm to struct file,
>>>
>>> I wasn't thinking of dropping kvm_get_kvm() entirely, rather just not exporting
>>> it.  Forcing internal KVM usage to grab a reference to the file doesn't add a
>>> whole lot value.
>>
>> It adds not doing things in two different ways. The kvm_file is not
>> always available (and if we need to add it, it should be added in
>> struct kvm not struct kvm_device).
> 
> My thought was to deliberately avoid putting it in "kvm", because as you're
> effectively pointing out, the file really shouldn't be passed around within KVM.
> 
> Aha!  What if we bury it in kvm_vfio?  As an acknowledgement that passing around
> a kvm_file is only intended for cases where an external, non-KVM entity needs to
> to propagate the VM reference.

That would indeed be best but it doesn't compile as there's no file 
argument to device_ops.create.  And adding it to device_ops is ugly as well.

Putting the backpointer in "struct kvm" seems the least bad.  I'll get a 
look again after finishing testing for the merge window.

Paolo

