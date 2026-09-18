Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A45239CCF2
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789723709; cv=none; b=GXEXF3uWMnbtBXgUvYAU6vrDvmXOhTALuYlkg7FGdDm+6FpL0qhB0qvR3EM/oX7q3jRERgRZSXLvCqN15I4wMLyO3eHtr7lYbrB6m6m5NfaW/e3VUSuXg+oXvVUOLIQR39Yf6f16umH6J0sG4KI/bY61cI3bC3icZSgUKC8G/rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789723709; c=relaxed/simple;
	bh=tYBKHE4ggx852HXzautUQ93L8BJ69LAKf0vSTSY3Zo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ATp0cbTjalVF6Z/gxdiSt6Cez5XcJj59H4BqgNTEF5+8S0QXdh44dRxYp6YoC+jsDuUrAGKXnpTVhKO+qmvXDCOgJb9PM8V1MTIOlUVR7xmWoy5mqJNKG/+pr1eO8oR+o+UVw7rQRtC1G4TNlj1VLT2V0wUcREVROZCLj9eXsjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Rcg1C6WL; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Rcg1C6WL"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B660B168F;
	Fri, 18 Sep 2026 02:28:23 -0700 (PDT)
Received: from [10.57.6.197] (unknown [10.57.6.197])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0778B3F882;
	Fri, 18 Sep 2026 02:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789723707; bh=tYBKHE4ggx852HXzautUQ93L8BJ69LAKf0vSTSY3Zo8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Rcg1C6WLOQm/5oo/BvAUOmKYpTngHeRnN/Wrbv8cgqaO273ngaLlEPZVUiY115TCz
	 iRCnYWbt8YnZbtQqSyzay55dfo9ZEZ81lfuKErsswRk/rF9+HLWrWK5S7QWxnxhP7W
	 T7j6lKfS0qPE2XNX/WK7hv9ul8/vPZBgyu5PrQ3k=
Message-ID: <e4bcc676-34d3-45ed-9eda-51c9a60e977f@arm.com>
Date: Fri, 18 Sep 2026 10:28:20 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Invitation] bi-weekly guest_memfd upstream call on 2026-09-17
Content-Language: en-GB
To: Ackerley Tng <ackerleytng@google.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, KVM <kvm@vger.kernel.org>
Cc: amit@infradead.org, aneeshkumar.kizhakeveetil@arm.com,
 ashish.kalra@amd.com, dwmw2@infradead.org, eberman@quicinc.com,
 fvdl@google.com, gshan@redhat.com, jackmanb@google.com, jackyli@google.com,
 jthoughton@google.com, kalyazin@amazon.com, kas@kernel.org,
 kevinloughlin@google.com, liruxin@google.com, michael.day@amd.com,
 michael.roth@amd.com, mike.rapoport@gmail.com, mvaralar@redhat.com,
 pankaj.gupta@amd.com, papaluri@amd.com, patrick.roy@linux.dev,
 Peter Xu <peterx@redhat.com>, pheragu@quicinc.com,
 pkondeti@qti.qualcomm.com, prty@google.com, psalian@google.com,
 qinkun@google.com, seanjc@google.com, shan.gavin@gmail.com,
 shivankg@amd.com, sidtelang@google.com, tabba@google.com,
 tatashin@google.com, vannapurve@google.com, vbabka@suse.com,
 wyihan@google.com
References: <b91dbfae-20f1-4b9f-a25b-4397afae80f9@kernel.org>
 <16ffff40-4ef0-4312-a700-348603f05c0c@kernel.org>
 <CAEvNRgGW_VHmT82q+bUqHh_5G2Z9sUF1jJOTiVN4Z8_cA9A50g@mail.gmail.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <CAEvNRgGW_VHmT82q+bUqHh_5G2Z9sUF1jJOTiVN4Z8_cA9A50g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ackerley

Thanks for the writeup, my responses in-line.

On 17/09/2026 19:41, Ackerley Tng wrote:
> "David Hildenbrand (Arm)" <david@kernel.org> writes:
> 
>> On 9/16/26 17:11, David Hildenbrand (Arm) wrote:
>>> Hi,
>>>
>>> Our next guest_memfd upstream call is scheduled for tomorrow, Thursday,
>>> 2026-09-16 8:00 - 9:00am (GMT-07:00) Pacific Time - Vancouver.
>>
>> Sorry, tomorrow (17) of course :(
>>
>> --
>> Cheers,
>>
>> David
> 
> I'd like to try and restate the conversion problem we discussed today to
> understand better :)
> 
> CCA's conversion protocol is:
> 
> 1. Guest tells RMM to convert a GPA range
> 2. RMM notes down, in a vCPU object within the RMM, the conversion range
> 3. On re-entering the guest, RMM tells the guest if the conversion
>     progress, something like:
>       + success, GPA start to GPA end was converted or
>       + failed, (with some error?)
> 4. Guest can
>       + Be happy that whatever it requested is fulfilled
>       + Retry to finish the parts that wasn't yet converted or
>       + Be sad that it failed and figure it out.
> 

Correct.

> I looked more into it and I'm surprised that what I was thinking of as
> "tell RMM to mark shared" isn't even correct.
> 
> RMI_RTT_SET_RIPAS() takes these parameters: rd (the realm), rec_ptr (the
> vCPU), base (GPA start) and top (GPA after, or base + size).
> 
> RMI_RTT_SET_RIPAS doesn't even take anything about shared or private!

This was deliberately removed because :

1. Host knows the original request from the VCPU exit.
2. RMM caches the request (range, ripas) in the VCPU object
3. Host confirms to the RMM, complete the RIPAS transition by
    RMI_RTT_SET_RIPAS(), with the values it received from the VCPU exit.
4. RMM matches the range provided by the host to match with the VCPU
    cached request and performs the "ripas" transition as per the
    request from Realm.


> 
> RMI_RTT_SET_RIPAS() is actually saying "host permits the conversion from
> base to top", it's not telling the RMM what to set it to, this is also
> different from SNP.

As mentioned above, host knows the requested "RIPAS" from VCPU exit.
RMM knows the "RIPAS" from the VCPU object.

Now: Privates vs Shared is translated to RIPAS_RAM vs RIPAS_EMPTY
in the CCA (well, roughly)

RIPAS_RAM implies, the GPA can be mapped into the private address
space of the Realm and it is integrity protected. Host cannot
replace the GPA with another content (it can unmap and DESTROY
the GPA mapping. But unless the Realm consents to replace the
GPA, again via SET_RIPAS request).


> 
> Interestingly RMI_RTT_SET_RIPAS() also errors out if the current
> shared/private state is different from the one tracked in the vCPU
> object in the RMM? Did I get that right? I'm looking at the base_align

Correct.

> Failure condition, where it says ripas_pre != rec.ripas_value.

Please note that, in such cases, RMM needs a deeper page table level
and the error is RMI_ERROR_RTT, indicating to the host that:
Look I need a deeper level table to satisfy the request.

e.g., base = 4K, but walk.level = 2, and ripas_pre="private"

i.e. the requested base is mapped at L2 as block with "private" ripas.
If you want to convert the "base" to shared, it needs L3 table. The host
would follow up with RMI_RTT_CREATE and then retry the request.


> If two vCPUs race to convert the same range to shared, both vCPUs would
> have rec.ripas_value = private. The first conversion would be fine, but

nit: rec.ripas_value = empty (shared)


> the second one woul see ripas_pre = shared but rec.ripas_value = private
> and would definitely get an error?

rec.ripas_value == empty (shared) as per the guest request. And the RMM
will find the state is already "shared" and would confirm the success
back to host.


> 
> And there's no "accept" step in the guest after conversions, which makes
> it different from TDX and SNP.

Correct, the guest "permitted" the GPA to be made private with unknown
contents anyway. RMM guarantees that the "data" is scrubbed when the
GPA is made valid. The advantage with this approach is, once the
Guest sets the RIPAS_RAM, the host can lazily donate pages at
fault time

> 
> Difficulty in using current gmem hooks that SNP uses:
> 
> * .gmem_make_shared() called from conversions doesn't have the vCPU
>    context, finding the right vCPU context is expensive.
>      * Sean, don't we already iterate vCPUs to find VMSA pages to kick
>        the right vCPUs?

We could keep a list of VCPUs with pending set-ripas request for e.g.
Or before the vCPU enter, we check the state of the region and
do the sync with RMM.

> * .gmem_make_private at fault time is too late
>      * At the next vCPU enter, the RMM would already read it's state to
>        report success/failure, and there's no fault in-between for the
>        .gmem_make_private to happen.
> 
> At the call Sean suggested mirroring the RMM's tracking in KVM, but that
> sounds quite arch-specific and it's like doing arch-specific validation
> within KVM.

Suzuki


> 
> p.s. Fuad, for pKVM you also mentioned that you'll need to check if the
> guest had requested for conversion first? This might be the same/similar
> problem.

