Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368AF37187C;
	Fri, 28 Aug 2026 10:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787914302; cv=none; b=ZJC8ukGCBZDz7JWRg0frOWAlZLy+HKeQx24k7DmDlG0Vmd+WSw8PRGQmicySMw+odDbcrFDQrQuIAxPfBO6JmMEz5j+9ErZA58U9YBRn18iAVmoMtZmZghzIMNmSH84RDYPyBXulYiU4pA0eo8uiiWd4CxH+xOWc4rW8/8uPNCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787914302; c=relaxed/simple;
	bh=f1tXItx/SP3I9fj2NGGQssr7Yz+M7GSEHOJzok3hWyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cFyFsCkDusgc5m3u4EZQjCs7p4UILmDYQXFASyV8C8kSD1JpaUxqAAVhfKtpG1uO8439ta1Ie0bZsQsFowQ/0/nJOuCpP0yN3O9Pz+BuWUxXcfimcjJGd7H/XUJHTfKiPXqEquPQRXxxZnxmgmIC6VPqpc5QOBmQxtL8nWCVlyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ecwos1c4; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ecwos1c4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=Dzg9V2iiWMedJBAhrJMj7UcTGQ4NjKAFQAxoUasMQno=;
	b=Ecwos1c4XqatUdoKcTHb2rGGteZVbEqjfK+aAZNBKiYP9hWF1d9UQmrOGRqkkK
	nkq1+EY+LfHGZD/tW3ay/8n5E+FHOO2SrysXMjU/kr5Jhib79VQsha0AYzmjBTFz
	bBWObrGEDCZjey6wcN9VWPD0pyD11talMFYChEi+MMCzY=
Received: from [10.42.12.146] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD311YaaJFq7cdwRg--.11167S2;
	Fri, 28 Aug 2026 18:51:07 +0800 (CST)
Message-ID: <7d00f8a3-0d35-49ce-83ab-29b94a3490ed@163.com>
Date: Fri, 28 Aug 2026 18:51:06 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: Release reserved xarray entries if reserving memory
 attributes fails
To: Sean Christopherson <seanjc@google.com>
Cc: pbonzini@redhat.com, chao.p.peng@linux.intel.com, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, zengchi@kylinos.cn
References: <20260827110558.457891-1-zeng_chi911@163.com>
 <apCD3F3oOyC6E5oN@google.com>
Content-Language: en-US
From: Zeng Chi <zeng_chi911@163.com>
In-Reply-To: <apCD3F3oOyC6E5oN@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD311YaaJFq7cdwRg--.11167S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCrykCr45AF45WFWkKr13CFg_yoWrXF48pF
	ZYgryUJrs5tFn7A3yktw4DZa4rurWSgr4rG3s8tryDZr45Ja4aqr95Kr4j9rW3JrZ5Wa4j
	qF4jqa47A3y0vaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U73kNUUUUU=
X-CM-SenderInfo: 52hqws5fklmiqr6rljoofrz/xtbCwBsf2mqRaBt+xgAA3u

On 2026/8/28 02:37, Sean Christopherson wrote:
> On Thu, Aug 27, 2026, Zeng Chi wrote:
>> From: Zeng Chi <zengchi@kylinos.cn>
>>
>> kvm_vm_set_mem_attributes() reserves an xarray entry for every gfn in
>> the range before modifying any attributes, so that the actual updates
>> can't fail partway through.  But if one of the reservations fails, e.g.
>> due to -ENOMEM, the entries that were already reserved are left behind,
>> as the error path bails without releasing them.
>>
>> A reserved entry is XA_ZERO_ENTRY, not NULL.
> 
> Lovely.
> 
>> xa_load() hides the difference, but kvm_range_has_memory_attributes() uses
>> xas_find() to check whether a range has no attributes at all, and xas_find()
>> returns zero entries as-is.  As a result, a leaked reservation makes KVM
>> think the range has attributes set even though kvm_get_memory_attributes()
>> reports none.  On x86, the next time mixed-attribute tracking is recomputed
>> for the range (memslot creation, or a later attribute change that straddles
>> the 2MiB page), hugepage_has_attrs() treats a fully shared 2MiB range as
On 2026/8/28 02:37, Sean Christopherson wrote:
> I'm inclined to fix kvm_range_has_memory_attributes() instead of unwinding the
> reservation.  Because this isn't a memory leak per se, e.g. if it weren't for
> the false negative in kvm_range_has_memory_attributes(), I would say this is a
> complete non-issue (there's no leak, just a maybe-unused reservation).
> working as intended.
> 
Agreed, fixing the reader is better.  Reframed that way in v2.

> I think it would be this?
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 65eb26a0520d..a01b2af1cb17 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2447,8 +2447,9 @@ bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
>  		return (kvm_get_memory_attributes(kvm, start) & mask) == attrs;
>  
>  	guard(rcu)();
> -	if (!attrs)
> -		return !xas_find(&xas, end - 1);
> +
> +	if (!attrs && !xas_find(&xas, end - 1))
> +		return true;
>  
>  	for (index = start; index < end; index++) {
>  		do {
> 
I tried that first, but it doesn't fix the false positive.  Falling through to
the generic loop for the !attrs case still returns false for a range that only
contains reserved (zero) entries: the loop does

	do {
		entry = xas_next(&xas);
	} while (xas_retry(&xas, entry));

and xas_retry() returns true for zero entries (xa_is_zero()), so it skips the
reserved entries, then "xas.xa_index != index" trips and the function returns
false.  So the leaked-reservation range is still reported as having attributes.

I confirmed it with the tools/testing/radix-tree harness (reserve [0, 512),
then query attrs == 0): the original code, the sketch above, and the sketch
with the xas cursor reset all return false, where absent is expected.

What does work is to walk the range and ignore the zero entries explicitly:

	guard(rcu)();
	if (!attrs) {
		xas_for_each(&xas, entry, end - 1)
			if (!xa_is_zero(entry))
				return false;
		return true;
	}

That gives the right answer for {empty, only reservations, a real value present,
reservations + a real value, all set}.

> Side topic, does storing NULL even require an entry?  Based on the above behavior,
> I assume not.  So can't we also do?  This feels like deja vu though...
> 
> @@ -2573,7 +2574,7 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
>  	 * Reserve memory ahead of time to avoid having to deal with failures
>  	 * partway through setting the new attributes.
>  	 */
> -	for (i = start; i < end; i++) {
> +	for (i = start; entry && i < end; i++) {
>  		r = xa_reserve(&kvm->mem_attr_array, i, GFP_KERNEL_ACCOUNT);
>  		if (r)
>  			goto out_unlock;
Right, storing NULL just erases and never allocates, so no reservation is
needed when clearing.  I folded that into the same patch (the reservation loop
becomes "for (i = start; entry && i < end; i++)").


Thanks,
Zeng Chi

