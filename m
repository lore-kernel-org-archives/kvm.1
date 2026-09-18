Received: from mail-qv2-f32.google.com (mail-qv2-f32.google.com [74.125.230.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA72F511E7E
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 16:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.160
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789748510; cv=pass; b=FXVhT0LYwbWZ7I9/w09zY79OqODKVJSRew7gdOA5j9rYp7sqLwebGHpeOCkFHEdispXzCLkyNUOrNVdnsE2mrzXno+b9oAkRj5AagW+Kz4zaCtfEWQZB7TgG/tG7AQGVCQOeChweD0RKWTFeBeH2mUadsj2pQGQwrd5VQczwmTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789748510; c=relaxed/simple;
	bh=92e2B6l5UHLzgZdhht9iA2YtEd1cLvpyijzpt6AhHc8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NOLbzS2+v38JQZ+jftFJaYXOOWfQVAAY4eQ5CQEQZ4S2psl+t6Q8z6ebfXaEKMriHz4sGh5tYeguY8OO6oUUxwkZ/TQM3c6qxtsJLspn4zCPNq5o305AhT/C8jssf5fuog2kGruH0AzEYkarwVvG+ofVgGWoYMb3QzOEabkJ1sY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XPgPhi7d; arc=pass smtp.client-ip=74.125.230.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XPgPhi7d"
Received: by mail-qv2-f32.google.com with SMTP id 6a1803df08f44-90ce6d5271dso5063916d6.1
        for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 09:21:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789748501; cv=none;
        d=google.com; s=arc-20260327;
        b=hQzFBCDJvJxxDN7fr+C9+qbcFAWQmtWryImhMMQPPZE3Qyfw+0lAEgMzMztQ8yBsGc
         PoB/bNrIBc5PMoM4w8zASn2ZoqkHAsDLTT3vStVSu3yl26sJP/wYQ7qZgPbzCS76rDuK
         D2Lef1MascEFyDoQ09gbDZOMCK6CHZ5LaeY0CgJHSIOxiYT3TIpBcKNS9ij8cUPQ4/GB
         iwFi+wJbVf6NzChObhe2SYrA6/ugsKV3cEUoKS49ytchupkispFbVZXCrfXf7GEVeMZ/
         R3yemUYKczXhsrmWz4Yjx+7Um0Lb6xbGetYpDzEv5RIFyZqckWaCelCdnQyOGMoK6vQQ
         68Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=k0idDGjqorNV8cxfogOvoluFO0wsP95B4F+1LnnDxZI=;
        fh=CbmxN33CSBjVKGgUXeWAfe4j2fwxWxvdtfgVL8+u3jo=;
        b=QILWjtxdG203Jb84lRx7/OUL54kOZqU2VpCQHB0c1S0C2lEcDoJ0cRS3S8gxtn5WlG
         BseEKXA1Zx7TamcDIxjIxceXNxoDyklooRc7TJ1wUn59lIfABj042YC+lpYJH8Fziko5
         BvUJNSggzVeEpKPFAnNC6QzVIR0OJFRYpJYts5auksZXJtn27vnmTy+A2DA6o4mBvnBQ
         JXRr0DioMReRusy5R9Zx68dq+RyHoaMVxiCvgUOfhBtCdGS5IXH/XClKoTrC2mhrY2hl
         XLZxYmx19AP9BFUqRjF8Zd86GkHzgwhCiE/cFZE4kxHvMsHZfoB8xQqHycFkEKwUyceY
         +42w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789748501; x=1790353301; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k0idDGjqorNV8cxfogOvoluFO0wsP95B4F+1LnnDxZI=;
        b=XPgPhi7ducvixgCJFIDNM16exHCcBoYBQ9F+P/7n8cpLZDuTP9Q5gs6wMxsodR8EqI
         SFDkZ5rHBMQbv3D/E9C2C7VdZywv/2pI6wY3FyEXxKQGCgEHCGTwdYwvdzQbLJ7vBsdk
         1CzzoEky3bGl9J1dmSl9u3bnCUVj52dXs9hphzncgncjMClA8LrMlPZL3b4iUvilbK96
         0MWovmrc0G8Uhf60nij6fV9Ms6Dl4W5qcEv6w/lBSH3IVXaUsUDqGWJp07x99zshO5n9
         RNcs5WRCBw1oUgx8JzHSJsyMu8PrBTOeaTtxEr9TuJuJEOzGNsGWVziT0jbs08CWPTiW
         i3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789748501; x=1790353301;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k0idDGjqorNV8cxfogOvoluFO0wsP95B4F+1LnnDxZI=;
        b=pd6Kh0DH6X73KOrA9tTquyqeoKVP2euA4pJWzT0QBAvlPV/z3UvLa4eGwkAELfzdgC
         fNa3X2ZwOt0aoVq8jvltoAXDBo1AduKISPFcrGCK5bxJoO61NzNX882JyMI9aiLQyOGy
         zBIVPG540Zbh9ehUD6DG4N2xDyI0pV7FIWxQO33HEJFgGab9WTTiNhBqVnnJIwDOYukm
         74oXpyj2vQW2cxh6xkjKK38ExJiEB7v43rUK5cAwAmM/DEOHsuoPGebroN2pbM5BAK/Q
         fiQDepBmcT2uD2e0T2IJpbpgjZD9LQ4qfd06cBGko6Rn8HmgcKvowNDDLGT54YNGza8E
         yb0w==
X-Forwarded-Encrypted: i=1; AKwUvBxLYs0m03Hkkj9+ye8lulbg9I1ngRzIBwPPCnciNqmX6b+7IbmvMNuAyZ4LIc/3uytvD5s=@vger.kernel.org
X-Gm-Message-State: AFuF++nV8BnT/wwt9iC2AKiQS4yJH71/Zw1WVxp2g8vcL3TOhmGcxB3m
	+V12oWq+kYaNlhr9WYQ5S9Xu3+80a3itX+54lsoZBcuNctN96T6C9mDuw2jqc0/CnrbKe6+5IQe
	A8lfGswIPCnatGWEah3y3hWyKJLTe2CwyKBYh+g94
X-Gm-Gg: AYBFou3HQiT3osLkR6PgR+URSIuhI+WpBCJ31CBZPLvWqp5+9mfX6F8dQ8/iLGMpYc4
	EbKxBMvExOeMUqJR2NoAyEde6dPOH+Bin+r3ySfxSbsnu1rFCxtqKyu4WuoLFxKh1DRqOljLT3e
	G9t5jGSq+DO619AWKuLZy6z4RLVv01GSt39v6P8SOu78zlL6R0D/GkIjSh1jEM/8Lr7ARW6tWA2
	JcsUB4oYVqi7SMyVzqixXvajRaAtOmgpmSDeJsXEKHNNOwOmDsYPHCCnDIs8xm3qnmMH/ZP/Gem
	te198Huwpg4HSpr6zHWqly5wn5c9g89mrB3yGmivI7wKDG03O7q300ocjf2zPpxoiwNWHu2biD0
	+vZunSZyp6/u8zAPohu5ETZkoXav0Ac2SWBa+6WVpe7c=
X-Received: by 2002:ad4:5421:0:b0:912:3b29:6580 with SMTP id
 6a1803df08f44-91254e64effmr32593386d6.7.1789748498548; Fri, 18 Sep 2026
 09:21:38 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 18 Sep 2026 09:21:37 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 18 Sep 2026 09:21:37 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <e4bcc676-34d3-45ed-9eda-51c9a60e977f@arm.com>
References: <b91dbfae-20f1-4b9f-a25b-4397afae80f9@kernel.org>
 <16ffff40-4ef0-4312-a700-348603f05c0c@kernel.org> <CAEvNRgGW_VHmT82q+bUqHh_5G2Z9sUF1jJOTiVN4Z8_cA9A50g@mail.gmail.com>
 <e4bcc676-34d3-45ed-9eda-51c9a60e977f@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 18 Sep 2026 09:21:37 -0700
X-Gm-Features: AcwNN1VzIl6ghPHchCrZF-oxqNdlGOgQjEVdlVOzWvyHTDDXwsaSi3qVUbQZQCE
Message-ID: <CAEvNRgFAL6qtSiJpQuga_TxWBr2pK=9LoiON+ZARMp0xFA8rPA@mail.gmail.com>
Subject: Re: [Invitation] bi-weekly guest_memfd upstream call on 2026-09-17
To: Suzuki K Poulose <suzuki.poulose@arm.com>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	KVM <kvm@vger.kernel.org>
Cc: amit@infradead.org, aneeshkumar.kizhakeveetil@arm.com, 
	ashish.kalra@amd.com, dwmw2@infradead.org, eberman@quicinc.com, 
	fvdl@google.com, gshan@redhat.com, jackmanb@google.com, jackyli@google.com, 
	jthoughton@google.com, kalyazin@amazon.com, kas@kernel.org, 
	kevinloughlin@google.com, liruxin@google.com, michael.day@amd.com, 
	michael.roth@amd.com, mike.rapoport@gmail.com, mvaralar@redhat.com, 
	pankaj.gupta@amd.com, papaluri@amd.com, patrick.roy@linux.dev, 
	Peter Xu <peterx@redhat.com>, pheragu@quicinc.com, pkondeti@qti.qualcomm.com, 
	prty@google.com, psalian@google.com, qinkun@google.com, seanjc@google.com, 
	shan.gavin@gmail.com, shivankg@amd.com, sidtelang@google.com, 
	tabba@google.com, tatashin@google.com, vannapurve@google.com, vbabka@suse.com, 
	wyihan@google.com
Content-Type: text/plain; charset="UTF-8"

Suzuki K Poulose <suzuki.poulose@arm.com> writes:

>
> [...snip...]
>
>>
>> RMI_RTT_SET_RIPAS() is actually saying "host permits the conversion from
>> base to top", it's not telling the RMM what to set it to, this is also
>> different from SNP.
>
> As mentioned above, host knows the requested "RIPAS" from VCPU exit.
> RMM knows the "RIPAS" from the VCPU object.
>
> Now: Privates vs Shared is translated to RIPAS_RAM vs RIPAS_EMPTY
> in the CCA (well, roughly)
>
> RIPAS_RAM implies, the GPA can be mapped into the private address
> space of the Realm and it is integrity protected. Host cannot
> replace the GPA with another content (it can unmap and DESTROY
> the GPA mapping. But unless the Realm consents to replace the
> GPA, again via SET_RIPAS request).
>
>
>>
>> Interestingly RMI_RTT_SET_RIPAS() also errors out if the current
>> shared/private state is different from the one tracked in the vCPU
>> object in the RMM? Did I get that right? I'm looking at the base_align
>
> Correct.
>
>> Failure condition, where it says ripas_pre != rec.ripas_value.
>
> Please note that, in such cases, RMM needs a deeper page table level
> and the error is RMI_ERROR_RTT, indicating to the host that:
> Look I need a deeper level table to satisfy the request.
>
> e.g., base = 4K, but walk.level = 2, and ripas_pre="private"
>
> i.e. the requested base is mapped at L2 as block with "private" ripas.
> If you want to convert the "base" to shared, it needs L3 table. The host
> would follow up with RMI_RTT_CREATE and then retry the request.
>
>
>> If two vCPUs race to convert the same range to shared, both vCPUs would
>> have rec.ripas_value = private. The first conversion would be fine, but
>
> nit: rec.ripas_value = empty (shared)
>

Sorry that was a bad mixture of pseudocode and constants on my part.

>> the second one woul see ripas_pre = shared but rec.ripas_value = private
>> and would definitely get an error?
>
> rec.ripas_value == empty (shared) as per the guest request. And the RMM
> will find the state is already "shared" and would confirm the success
> back to host.
>

Oh yes, my bad.

base_align says (rephrased)

  if (!AddrIsRttLevelAligned(base, walk.level) &&
      ripas_pre != rec.ripas_value)
          return RMI_ERROR_RTT

Is the alignment check to do with another vCPU splitting the record in
the table?

Why compare ripas_pre and rec.ripas_value when the level is not aligned?

>
>>
>> And there's no "accept" step in the guest after conversions, which makes
>> it different from TDX and SNP.
>
> Correct, the guest "permitted" the GPA to be made private with unknown
> contents anyway. RMM guarantees that the "data" is scrubbed when the
> GPA is made valid. The advantage with this approach is, once the
> Guest sets the RIPAS_RAM, the host can lazily donate pages at
> fault time
>
>>
>> Difficulty in using current gmem hooks that SNP uses:
>>
>> * .gmem_make_shared() called from conversions doesn't have the vCPU
>>    context, finding the right vCPU context is expensive.
>>      * Sean, don't we already iterate vCPUs to find VMSA pages to kick
>>        the right vCPUs?
>
> We could keep a list of VCPUs with pending set-ripas request for e.g.
> Or before the vCPU enter, we check the state of the region and
> do the sync with RMM.
>
>> * .gmem_make_private at fault time is too late
>>      * At the next vCPU enter, the RMM would already read it's state to
>>        report success/failure, and there's no fault in-between for the
>>        .gmem_make_private to happen.
>>
>> At the call Sean suggested mirroring the RMM's tracking in KVM, but that
>> sounds quite arch-specific and it's like doing arch-specific validation
>> within KVM.
>
> Suzuki
>
>
>>
>> p.s. Fuad, for pKVM you also mentioned that you'll need to check if the
>> guest had requested for conversion first? This might be the same/similar
>> problem.
