Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6F426E173;
	Sat,  1 Aug 2026 18:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785608077; cv=none; b=Z/GSS9ArXuexwG4UcIYHbyC1H9Li6nSCjUftr5KWgdgfvXR5i9ledJ6m0Hv8ZEScBu7buQT9Sh5+szyR3YSh208a3VmGuOy+spACPxMKyLuRDEMGRd/+/tLj9Rltvv5D1oLSxBv0lBOffeHtAiqWgneFFl5UhutcDpmHX1vp2do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785608077; c=relaxed/simple;
	bh=Yb1hU74A3S9CVp+ABKEU0BJelXX/U8llns+ohxnrYyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cqdaY0PCGfDPChPqn0GXHlejaKlwgSO7HpiaBuFEBJXhV7afFCZze55z+w3O3fQtsXLCeqCd1qIOY1AMm8YmzMT/AQd0L3JQK7gLoyVnIfXby4b3HRzTkklDfacY9F68pqIyE2xVzjljl0a9Ws2zgD5YLKXuaxw2PKCgPd9zQpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yCyfNo4/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yCyfNo4/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=QuBl/cyk6WkMiSlkYTuIjIVYKEnZ1o22nS/lC518xZY=; b=yCyfNo4/s+GGm5+FZgAVnoMDky
	H0lRXEaTqlnu6WlZdkDD6qucfhnYiBFObnvOOHe+ScYn1uA9R7p+G5OextNtGAqmwz+Nhgy7gutOa
	Mt+W7lN5eMDoGcF6wz4aN0K6sR4+pKFjTykVM/lWmGNlqRvmGX54klSh4e33EYv5SAzgarYfB8+aD
	Rt9lDt2ZyV2yRtBbN9uO9+wRWhChpIuaV6sPco/QWQ5/DluUEKfBSGblJSU0iJtdtaAAmOjTkJfGP
	HBO2hYa29n6CnJswdpqWHwhjJI72OKdmsVy2yLqek8DMKP+2fZdIgFeqh5R6oZTYQE09HAK89dNpH
	PzzbAmvg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqEEB-0000000Ewpp-3Evy;
	Sat, 01 Aug 2026 18:14:31 +0000
Message-ID: <e7e85814-3f8e-49d1-823d-70bf49387d01@infradead.org>
Date: Sat, 1 Aug 2026 11:14:30 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: KVM: fix heading level for
 KVM_S390_VM_CPU_PROCESSOR
To: Kohei Enju <kohei@enjuk.jp>, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260801064414.23747-1-kohei@enjuk.jp>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260801064414.23747-1-kohei@enjuk.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/31/26 11:44 PM, Kohei Enju wrote:
> Change the section title underline from '=' to '-' so that the attribute
> is at the same heading level as the other attributes.
> 
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>


Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/virt/kvm/devices/vm.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/virt/kvm/devices/vm.rst b/Documentation/virt/kvm/devices/vm.rst
> index a4d39fa1b083..71ab1351ad27 100644
> --- a/Documentation/virt/kvm/devices/vm.rst
> +++ b/Documentation/virt/kvm/devices/vm.rst
> @@ -77,7 +77,7 @@ Allows user space to retrieve machine and kvm specific cpu related information::
>  	    0 in case of success.
>  
>  2.2. ATTRIBUTE: KVM_S390_VM_CPU_PROCESSOR (r/w)
> -===============================================
> +-----------------------------------------------
>  
>  Allows user space to retrieve or request to change cpu related information for a vcpu::
>  

-- 
~Randy
