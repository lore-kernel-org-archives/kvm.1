Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7EF492E28
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 23:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788909159; cv=pass; b=BN1PqJ99jKXqK686k07U2QqoNajCfE5ViHSIijcQ38EraWTWatTyo3WF/IGBA6ti8L3Vm9cp2NXk3SIpzo+4DbrS4rbvIZy+8ouk3MAGC89kSqijWvgHGgoSaLwhW9HNb/H+3d3u85+KtECzf9gIMC0V5YTqoET/LB8TnZoPhYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788909159; c=relaxed/simple;
	bh=gZmq25Z+awQ0y4lsukMZ+pIMcjN1YfhRCjiVRgC6fR8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZJODqmiFjJYeyPBOflOo91uH2S+t8HhbVY5PJhoalTFN6VCnM8Dpt+8X0lusCM6piwKOUCmI1N8WAk1hVGx0zf8NagsYY7bWmDC/JFEBk7Gn7hRysCxtbOwNajWD4il/1Lo4Ax84nwyvGoTb7nueiEySKG2wFNF656Wmbvbsqxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JmqYyQtQ; arc=pass smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JmqYyQtQ"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-939cc5761d4so10962285a.3
        for <kvm@vger.kernel.org>; Tue, 08 Sep 2026 16:12:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788909156; cv=none;
        d=google.com; s=arc-20260327;
        b=SV0nj4PNU3Cdk+vpHq2kpUFXPjy9ItQAsBpMpeRVbvvjFKH8kjVAP0v43dKU00zkE9
         98kCxZhdFGUIGqqJnFUYP2/OU95W1Tx/6raXKmvyGnxG+ilCYLMrY1uy80ow/da/sps0
         MHNiJOh3A4ffIpjHs7tmvCkMOu8HoJ7KhLxz6Xe8FS2maJuGIjs8cpuBsQvFdHKxW2jO
         cY1tIfksvgi3KHkHmLF6g+hLMsh8dX+MrvffK2DXzDqFys8Z5xFWz3wAysVpqQOcBPjs
         nOhx6EVJRwU3wv9WTZHRsTomBxjuCHfdH6FLmWsWSql/Bnmaa+lmLw6wjXTDm060Hw8Q
         bqtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=bXe1j20I+di0M3C6cOcnKJ1R5Cd+V17GNEUEr8u82pc=;
        fh=4aYaDOrtZD5j6Z6c63R1pJvq2Y40pwlaCLNrQk8m1jU=;
        b=UbwcMVV4y8JCd+gRk0eOIXaQWKNEtdHVkEhI8HqmZ6kuPRCbeoB8m8p0QiZddmKZZU
         ywQOoUEh5y/tBnpB4YaL2oqSbz41o+JEP4T34a1AOTCT0z5oDqdvh49Kf0RRhkU0N2Nk
         m2Vjhm8ZA444+gS1ReN5w9rPcnY3wwTfER1i4wENJtE1oPhsuKBRqzrs8Z+NdYWFtYLB
         UkBxoDt23p4tW8z36PP8My47V+tH6W+ATiUl0hCbsvv8kABoU0PHp92r63Dc6PsJiZCB
         lH4sqe7jswufS5UYwGpXVpyVEtl2Qg/DPuuk9in5Nxtzd/LVSoI9k6vn6JDqFg0Rx1OV
         uSkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788909156; x=1789513956; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bXe1j20I+di0M3C6cOcnKJ1R5Cd+V17GNEUEr8u82pc=;
        b=JmqYyQtQNeIrOnzlT0pkf6bmVFsv7J5F/N2i+FylmkR9o34TJRrdsBeEj3QohYyBef
         FlWCbzRf+QH4Gq+hSUwROlCHqfbjZ8Du066oIi0Ud7KHOofKb3irykyQwVLEQfdLYsR4
         dNwDwTvHJPls4P18W0535sas10f/C3sx8TGo9VchaRs/kdybXO1+h/H+ugqXBBs+9OvY
         NfPLfgLaOfCtqcqs+BGe9iqmJ7ivb/2feskeKd8Mc3U0FBtoGZRWIS8/pT9ePhfhZcxM
         YL3K6JxEJoEU+m58ER9DgngS8/Upbc7LDD6kZdJ9vXuJ6auUS2tX1UEM2O4RJ48inyqt
         N9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788909156; x=1789513956;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bXe1j20I+di0M3C6cOcnKJ1R5Cd+V17GNEUEr8u82pc=;
        b=bgV8DFaRrzD0gmFDyup+VcbzENBBK6mxJ6qaL+ATe4zWAmSv6dWhb89JaOLPpuAwyh
         pm8Xxmu0Y6VCypBZDAaNhpUQpnjoZg3fhEgJUtP6wnX/mkChIt1RRPmy3dpHa04TWcKr
         4QMCaLDJwO+jlFT349J1d8H1MEMSabGWXPhYiebJqhLrCSUfIALIxbUUJrX4Utu2dnzc
         gQSKhY+pOLPuSQOy+vZY190nR31Jz/VWellmwOGUxtOFC0jXzDLFBWbw7cWxiT6YT+Pa
         qSr85Ou/Jki9zuaiLn10Z0grZKcZkpXWC8d56Wl5GLsJQnn6860WTpAUFBrH90Uax31A
         h8qA==
X-Forwarded-Encrypted: i=1; AKwUvBzWmEHoJC+SfcbF/3ZaC3AkF8Bmy0yI1/xhkl9E/31EVq2IjTylDSuuAjklTXF/nFZvRNc=@vger.kernel.org
X-Gm-Message-State: AFuF++kEwAwX0GrfEi9M6HEjDDKZcREanXe31rOcSpMIo4FaL6JDpS6K
	20jJNt7q1//ZgltXXLve7P76dKm4ae6UW/CmWxLajTRs0skVmS2/jXzDsrgHP39IgfCBtTtsguP
	4cuOmlIrRqZmdJmi4rDCubyuSwlOJ5B9W0phA5+se
X-Gm-Gg: AYBFou2vih4+Fwgg011KSWa/b9WsGDUMwE7REOBmM13VSvZTeDcLT7+UaKoCTTjGhBR
	TeGulngVCiVY4ZsfnHeVnMP0YujQWiWo1fbjnbpw16l/980MKZpV0fXyUg0pFr6/VokX5+BXpE4
	LhpU9afFr+vsCX7R2Hw2+Bjy7Ih5HckEyYUvnvJCP5cDRLFODqeF6DVsGzL6fONUoaIQaCmPXbB
	wX46R7sFftdqaTBJ9NDaP0iXYUy52qFPIySU103/nV8W169rcG4tUkiQYn/XuDZtKTMjWn7hthw
	aZjosiyyhlkb3AsPPKf+xLN9e+oaaNASD5UEK8DmnH9wqtN0wmZm7xQpEDUps7m1GF5iAAVLNeF
	D0S6Rd8h201pH5z+bnx/9ilTVl1JBhv4=
X-Received: by 2002:a05:620a:6081:b0:936:69dc:aedf with SMTP id
 af79cd13be357-93980370c3bmr3268519485a.16.1788909154992; Tue, 08 Sep 2026
 16:12:34 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Sep 2026 16:12:34 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Sep 2026 16:12:33 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <e5cefe2e-5cde-45c5-8d28-e64b434a0c2e@intel.com>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-18-15ad654a50db@google.com> <befe73e1-3287-440e-90de-6c62f6c19d47@intel.com>
 <CAEvNRgH00s3NWUH8EGUZq3WWweboBcUaTZs_0Cye5D=3o0OALQ@mail.gmail.com> <e5cefe2e-5cde-45c5-8d28-e64b434a0c2e@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 8 Sep 2026 16:12:33 -0700
X-Gm-Features: AcwNN1URYxq6dasdi_5TWC8QB03_0MMIfEhWxTak9rckb9UYchDGFf-lhLQ-wFc
Message-ID: <CAEvNRgE8_RXfNidbddA238ScxSzf_DcuGR6P--7dKZTU81fSeQ@mail.gmail.com>
Subject: Re: [PATCH v14 18/22] KVM: selftests: Add helpers to init TDX memory
 and finalize VM
To: Xiaoyao Li <xiaoyao.li@intel.com>, Lisa Wang <wyihan@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Chao Gao <chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Erdem Aktas <erdemaktas@google.com>, 
	Ira Weiny <ira.weiny@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Kiryl Shutsemau <kas@kernel.org>, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Ryan Afranji <afranji@google.com>, 
	Sagi Shahar <sagis@google.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> On 8/17/2026 9:52 PM, Ackerley Tng wrote:
>> Xiaoyao Li <xiaoyao.li@intel.com> writes:
>>
>>>
>>> [...snip...]
>>>
>>>> +static void tdx_load_private_memory(struct kvm_vm *vm)
>>>> +{
>>>> +	struct userspace_mem_region *region;
>>>> +	int ctr;
>>>> +
>>>> +	hash_for_each(vm->regions.slot_hash, ctr, region, slot_node) {
>>>> +		const struct sparsebit *protected_pages = region->protected_phy_pages;
>>>> +		const gpa_t gpa_base = region->region.guest_phys_addr;
>>>> +		const u64 hva_base = region->region.userspace_addr;
>>>> +		const sparsebit_idx_t lowest_page_in_region = gpa_base >> vm->page_shift;
>>>> +		void *source_pages = NULL;
>>>> +		sparsebit_idx_t i, j;
>>>> +
>>>> +		if (!sparsebit_any_set(protected_pages))
>>>
>>> sparebit_any_set() doens't check if the input is NULL. So we need to
>>> check it here.
>>>
>>>> +			continue;
>>>> +
>>>> +		TEST_ASSERT(region->region.guest_memfd != -1,
>>>> +			    "TD private memory must be backed by guest_memfd");
>>>> +
>>>> +		sparsebit_for_each_set_range(protected_pages, i, j) {
>>>> +			const u64 size_to_load = (j - i + 1) * vm->page_size;
>>>> +			const u64 offset =
>>>> +				(i - lowest_page_in_region) * vm->page_size;
>>>> +			const u64 hva = hva_base + offset;
>>>> +			const u64 gpa = gpa_base + offset;
>>>> +
>>>> +			if (!kvm_has_gmem_attributes)
>>>> +				source_pages = (void *)hva;
>>>> +
>>>
>>>> +			vm_mem_set_private(vm, gpa, size_to_load);
>>>
>>> So vm_mem_set_private() has to be called at this late stage when run
>>> with in-place gmem. But for non in-place gmem, we can actually call
>>> vm_mem_set_private() in __vm_phy_pages_alloc().
>>>
>>> Calling vm_mem_set_private() here instead of in __vm_phy_pages_alloc()
>>> looks like a trick to me.
>>
>> I thought this is fine because __vm_phy_pages_alloc() seems to be a
>> rather low-level function, where the responsibility of the function is
>> just to allocate (for find some physical pages). Calling
>> vm_mem_set_private() in there seems to be doing too much.
>
> __vm_phy_pages_alloc() takes a parameter @protected, which is used to
> tell the allocated physical pages need to be protected(private) or not.
> It looks weird that a page is allocated as protected but actually it is
> still shared.
>

I think there are a few different things here:

1. Finding some range of guest physical addresses for a page. This is
   __vm_phy_pages_alloc().

2. Tracking the guest physical addresses as shared or private in the
   userspace VMM. This is setting region->protected_phy_pages.

3. Creating private vs shared mappings in guest page tables. This is
   done in __virt_pg_map().

4. Transferring region->protected_phy_pages into the kernel. This is
   either the VM or guest_memfd conversion ioctl.

5. Loading private memory based on region->protected_phy_pages. This is
   done in tdx_load_private_memory() and the SNP counterpart.

So protected_phy_pages tracks all the pages that will be initialized as
private, not the pages that are private (since vm_mem_set_private()
doesn't update protected_phy_pages).

(2) is coupled to whether the VM has protected memory in
vm_phy_pages_alloc(). This is kind of an awkward assumption since a CoCo
VM can have shared memory too, and especially for selftests there can be
shared pages right from the start.

However, setting protected_phy_pages in (2) and referencing in it (3),
(4) and (5) makes sense since that's the common path, and we want the
common path to be easy for the selftest writer.

I think there could be some refactoring so that the different components
1 through 5 are opened up for easier usage but I haven't thought about
how it should look like and anyway I think that belongs in a separate
series.


Imo the direct response to looking allocated as protected but is actually
shared is that the page was allocated as "will be loaded as private",
and doesn't make any statement on whether it is shared or private.

Does seeing protected_phy_pages as "will be loaded as private" help in
explaining why vm_mem_set_private() is not called in
__vm_phy_pages_alloc() but is done only in tdx_load_private_memory()?

>>> That is, we cannot set the page as private
>>> when allocating a guest physical page as protected because if doing so,
>>> we cannot write the initial content to it.
>>>
>>
>> I think calling it here isn't a trick, it's a good way to reuse all the
>> existing code that builds up the guest image in place. In-place
>> conversion allows you to set stuff up in shared memory and then convert
>> everything when you're done and also populate the memory.
>
> This is based on the assumption of "in-place conversion". However the
> TDX selftests should be able to run without "in-place conversion". There
> is no hard dependency on it.
>
> I think this patch implements what patch 13[1] of this series says "For
> CoCo VMs, pages that need to be private are explicitly set to private
> before executing the VM."
>
> But all of this is for the case of "in-place conversion". When "in-place
> conversion" is not supported/enabled by the kernel,
> GUEST_MEMFD_FLAG_INIT_SHARED for Coco VMs is *not* allowed and all the
> memory are private by default and no need to call vm_mem_set_private()
> here at all.
>
> [1]
> https://lore.kernel.org/all/20260722-tdx-selftests-v14-13-15ad654a50db@google.com/
>

Doing (3) as part of (5) isn't just for in-place conversion. Without
in-place conversion, source_pages should be the address mmap()-ed from
some non-guest_memfd memory, which by the time of
tdx_load_private_memory(), would already be populated with whatever
needs to be loaded. Populate needs to be called on private memory
regardless of whether we use in-place conversions.

>>> This is the topic about how to implement the infras for in-place gmem,
>>> not the issue of this series. Let me go read the selftest patches of
>>> gmem in-place series and we can discuss there.
>>>
>>>> +			tdx_init_mem_region(vm, source_pages, gpa, size_to_load);
>>>> +		}
>>>> +	}
>>>> +}
>>>> +
>>>> +void tdx_vm_finalize(struct kvm_vm *vm)
>>>> +{
>>>> +	tdx_load_private_memory(vm);
>>>> +	tdx_vm_ioctl(vm, KVM_TDX_FINALIZE_VM, 0, NULL);
>>>> +}
>>>>
