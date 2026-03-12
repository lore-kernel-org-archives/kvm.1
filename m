Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97923AB290
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 21:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773352789; cv=pass; b=X1cR/+JcKqFQ7eByy/NMWfBEAT/JuFUmAeygjK8LVVVQAHyKaifw50IOux1HOI0m2CHbxbPQGDVQdcITzvpdsgjZf9z2CwAF7paGnq+Qb9BSJR3KdnLHHPepnQi+3fZsErXwYBA8dkHKWDrRwPupw4e5KsKfYs0CZenrti7lLbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773352789; c=relaxed/simple;
	bh=eApaaw+QCMTnSsMJ8+tm4DDnuq11/fr0BZGkfu7iBV0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ag29jvpdNImfNgXsEneByrRpcEQA90XwkKnAOM+dPTnNpnsKHkJ0acTB6iSWlRKWH4BxTKDcke+2nieI1LnK9VdyCzgAZTXygoNedzObczxdb3Hfoy+gbKA3g4Xe9qmOF7DJ9K8Tf/yLFn1Hge6BEbyVZJcUXu/qCQP5UJwzamU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VnY3Tb8C; arc=pass smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VnY3Tb8C"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-56b069fed64so631949e0c.2
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 14:59:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773352787; cv=none;
        d=google.com; s=arc-20240605;
        b=Wpx9cdTAp4sDLJa0HkB2HVCZIFH9J4ch5nPVNVhNh2wHN9YmMiXoUXsLy+V5idHNRr
         HcJqYd3UqfPasuT3jAqK7j5YEGOAf3kSIXLFw1IyX/bu5/xaOefukLy1nEZgwjYaUU/9
         fHZCQLH22F1xJzURRJO0eO4t/TZm9m5352z8/qszI4E5c8OkAC/Ad0c99OkRm2i0zKGK
         8fLmU5dPETcT2raE5dxKI1ViEUsE0XmG8yRn+J+HvRvFZF+H3CCYfYaUg88E55z05e5t
         D0gMC6v1yacErxuNzEJVDmHOclfGVQZ8s18kldUsF4lob2MCgnTvuatESsEYdociv9Ht
         WWcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=5BRi8Q65G/TYxzzc8DUJBOspDF6bBOCx0tLSyw1Him8=;
        fh=fy+EN+7a7bCj+TUH/FyqDrPuaJ/HvFmZ3UHyaSEM4mw=;
        b=XyZay63NW/b6Se0wUh/yaJlzyB04S9HvwgdwEWtfkIj8oZQOPWFJWVWba6MbBHdOq6
         t585o17E/9iXIGo20DEXMYUaBPvWrptrxl+5rTYjSij1+Eg0h1vPOgsTGc22BbteGmyt
         VA7Mkdy5k8zS0cPxuxYL85x9HQZ4cnpykyRKKVnM9EvoH9fEfIkZam+udgb6D4xF62aX
         LB3/w6Mtfk9DR8enm6uFbOGhyjGXGBUtooBmdWJHqHsB1naMxYjHeo18GX/h5nnn9g++
         odkr2wJO+BHrn+nxsAjsqm5QR5w/9ckD4APnlSDSVeiv/D49latILOEKA80ncK4z6MeY
         nsqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773352787; x=1773957587; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5BRi8Q65G/TYxzzc8DUJBOspDF6bBOCx0tLSyw1Him8=;
        b=VnY3Tb8C1k7MPfmNMOinISFxSc/HSNaroC8BgoRQg+0jNSCDJEs+uFaLn1o+hNP+ra
         qyiOYvhUMb/3PdKLspBHReEMr4lOkxMBoTBWKJlPQfB7q/VyKFUB/Bw1OK2GrmrqydpG
         5EfydhrHqqkVwDsVNzrKT0yF/yvs8TkEc3bDqr7Ufp5FUOM8LY1CjdKDcGwWNRk5PKfH
         e9GNYYMyWkQwJiWmcvtNM+0BIN4h6dU3WlxYGxjfecD7yzbVskwME3Bp/M6amEXVRXpP
         BCWK8ac2CfJvFlQ23K6jvJifTj5gTbdQkQjpSKis0K2elNNBk4hpt/j6Hh19lCbDvrix
         X83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773352787; x=1773957587;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5BRi8Q65G/TYxzzc8DUJBOspDF6bBOCx0tLSyw1Him8=;
        b=gkaUkE3ZYwFeNGgzj6jlnnP+BooIHWg9MHCIEWpdSgR1FJfac511dAtSRi/v86oQvv
         oWYbybcKizSkdWxEtkYptRktuPut8Ut24WaSvYomDpA5kV372fXcfBxlmlf5dzGBWTW6
         krv9TQtFgHU1VhHzcEU63rLP8efpCq9PqHySNjMZ/ptq6ZM1uqAySRPf3f72qmKNXfRP
         vkwvuBDlL8ly/KG5MldWBmsc6iilrzGHY1RrNfYErL/o6Q1dzYzDCXp+Dwg4Q/L8pwze
         /du2kzNbkMhdULbqKM3G0d6AkvzerkySokjWr5WvcBaSWIsw5BmEZh7Pv/+nk5VcgnrF
         yZZg==
X-Gm-Message-State: AOJu0YxtMwntolnMAOoZlrRyJPm1lhlCB/uyl6xzcBAaaTWoiti6y/+t
	T3tvpHh/Jr7kHB93YXFh0IG+hxFbOOcy0QcAjmyWTbnd/hiMPqTTWyl+cF795WNFn8Fo2b6jqHi
	W1wxas+FoE5+F0wLUtuvVPRd/+2xTbEM1OdHcJcHB
X-Gm-Gg: ATEYQzxLBx/CcPeCTgfvh0n8HALu6og817tppecx4LyV5aFHVvKbdf0hxvxBa35F/+f
	eQWzayc2A05GOo3X/RyWH02u2zp81+yWfBk+auvRHO12m7ZYdJnGA1w0bF9T3u4amQHh2wlHdgC
	OZxOvcPv7NWPPcTAFIy6Jm2mCGXJVBrvX/0OKyHfAQPraxVfOstqdb28XImT8V653H4U0/zkKzJ
	JHKID8ZD+BiVzsCNWc/SsP4ax62fdt4VMtgCod+CtJo7ZJmjztOUZMsU/HrGBLmMh005gGiO7N7
	a3il55cvqE5QIoSz3HYKLZPnHt2l/YuUTmuxqDm3
X-Received: by 2002:a05:6122:16a0:b0:55b:1938:9183 with SMTP id
 71dfb90a1353d-56b627e8184mr386492e0c.4.1773352786246; Thu, 12 Mar 2026
 14:59:46 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 12 Mar 2026 14:59:45 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 12 Mar 2026 14:59:45 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <abLfWHf89TxWqeGZ@google.com>
References: <cover.1770071243.git.ackerleytng@google.com> <86ad28b767524e1e654b9c960e39ca8bfb24c114.1770071243.git.ackerleytng@google.com>
 <CAEvNRgFMNywpDRr+WeNsVj=MnsbhZp9H3j0QRDo_eOP+kGCNJw@mail.gmail.com>
 <CAEvNRgG-L+GBcm+u_thGvXAxV-Nqzu5VtgXy0PfND6SG0FiyVg@mail.gmail.com>
 <CA+EHjTy2urW2Tj5czQDKUHdri7FCLfw2mafTgmmtFs+-7ueoiw@mail.gmail.com> <abLfWHf89TxWqeGZ@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 12 Mar 2026 14:59:45 -0700
X-Gm-Features: AaiRm51WdPA9PYhHM87YIJzRBZGaRjiFMDr05z8vln4-gPCqggi2FDd5_-4bZTU
Message-ID: <CAEvNRgFUc+9xCoN9Yo5NThHrvbccWAhPwp9nNM2fvx7QqrcJsg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/37] KVM: guest_memfd: Add support for KVM_SET_MEMORY_ATTRIBUTES2
To: Sean Christopherson <seanjc@google.com>, Fuad Tabba <tabba@google.com>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, aik@amd.com, 
	andrew.jones@linux.dev, binbin.wu@linux.intel.com, bp@alien8.de, 
	brauner@kernel.org, chao.p.peng@intel.com, chao.p.peng@linux.intel.com, 
	chenhuacai@kernel.org, corbet@lwn.net, dave.hansen@linux.intel.com, 
	david@kernel.org, hpa@zytor.com, ira.weiny@intel.com, jgg@nvidia.com, 
	jmattson@google.com, jroedel@suse.de, jthoughton@google.com, 
	maobibo@loongson.cn, mathieu.desnoyers@efficios.com, maz@kernel.org, 
	mhiramat@kernel.org, michael.roth@amd.com, mingo@redhat.com, 
	mlevitsk@redhat.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	pbonzini@redhat.com, prsampat@amd.com, qperret@google.com, 
	ricarkol@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, shivankg@amd.com, shuah@kernel.org, steven.price@arm.com, 
	tglx@linutronix.de, vannapurve@google.com, vbabka@suse.cz, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Thu, Mar 12, 2026, Fuad Tabba wrote:
>> Hi Ackerley,
>>
>> Before getting into the UAPI semantics, thank you for all the heavy
>> lifting you've done here. Figuring out how to make it all work across
>> the different platforms is not easy :)
>>
>> <snip>
>>
>> > The policy definitions below provide more details:
>
> Please drop "CONTENT_POLICY" from the KVM documentation.  From KVM's perspective,
> these are not "policy", they are purely properties of the underlying memory.
> Userspace will likely use the attributes to implement policy of some kind, but
> KVM straight up doesn't care.

Policy might have been the wrong word. I think this is a property of the
conversion process/request, not a property of the memory like how
shared/private is a property of the memory?

I'll have to find another word to describe this enum of

* KVM_SET_MEMORY_ATTRIBUTES2_ZERO
* KVM_SET_MEMORY_ATTRIBUTES2_PRESERVE

>
>> > ``KVM_SET_MEMORY_ATTRIBUTES2_CONTENT_POLICY_ZERO`` (default)
>
> The default behavior absolutely cannot be something that's not supported on
> every conversion type.
>
>> >
>> >   On a private to shared conversion, the host will read zeros from the
>> >   converted memory on the next fault after successful return of the
>> >   KVM_SET_MEMORY_ATTRIBUTES2 ioctl.
>> >
>> >   This is not supported (-EOPNOTSUPP) for a shared to private
>> >   conversion. While some CoCo implementations do zero memory contents
>> >   such that the guest reads zeros after conversion, the guest is not
>> >   expected to trust host-provided zeroing, hence as a UAPI policy, KVM
>> >   does not make any such guarantees.
>>
>> The rationale for not supporting this in the UAPI isn't quite right
>> and I think that the prohibition should be removed. It's true that the
>> guest is not expected to trust host-provided zeroing. However, if the
>> VMM invokes this ioctl with the ZERO policy, the zeroing is performed
>> by the hypervisor, not by the (untrusted) host.
>
> What entity zeros the data doesn't matter as far as KVM's ABI is concerned.  That's
> a motivating favor to providing ZERO, e.g. it allow userspace to elide additional
> zeroing when it _knows_ the memory holds zeros, but that's orthogonal to KVM's
> contract with userspace.
>
>> Although pKVM handles fresh, zeroed memory provisioning via donation
>> rather than attribute conversion, stating that the UAPI cannot make
>> guarantees due to trust boundaries is incorrect. The hypervisor is
>
> We should avoid using "hypervisor", because (a) it means different things to
> different people and (b) even when there's consensus on what "hypervisor" means,
> whether or not the hypervisor is trusted varies per implementation.
>
>> need to be careful witho precisely the entity the guest trusts to enforce
>> this.
>>
>> The UAPI should define the semantics for a shared-to-private ZERO
>> conversion, even if current architectures return -EOPNOTSUPP because
>> they handle fresh memory provisioning via other mechanisms (like
>> pKVM's donation path).
>>
>> How about something like the following:
>>
>> On a shared to private conversion, the hypervisor will zero the memory
>
> Again, say _nothing_ about "the hypervisor".  _How_ or when anything happens is
> completely irrelevant, the only thing that matters here is _what_ happens.
>
>> contents before mapping it into the guest's private address space,
>> preventing the untrusted host from injecting arbitrary data into the
>> guest. If an architecture handles zeroed-provisioning via mechanisms
>> other than attribute conversion, it may return -EOPNOTSUPP.
>
> No.  I am 100% against bleeding vendor specific information into KVM's ABI for
> this.  What the vendor code does is irrelevant, the _only_ thing that matters
> here is KVM's contract with userspace.
>
> That doesn't mean pKVM guests can't rely on memory being zeroed, but that is a
> contract between pKVM and its guests, not between KVM and host userspace.
>

If pKVM's (kernel, or elsewhere) documentation says something like

  Shared to private (in addition to private to shared already specified
  in the userspace/KVM contract) conversions through guest_memfd
  specifying ZERO will have memory contents zeroed.

Would that then cover both perspectives? I see Fuad's point that pKVM
would like to provide guarantees in the shared to private direction too,
and I see Sean's point that the shared to private direction isn't a
userspace/KVM thing.

The awkward part is that we guarantee both directions for PRESERVE but
not for ZERO.

>> >   For testing purposes, the KVM_X86_SW_PROTECTED_VM testing vehicle
>> >   will support this policy and ensure zeroing for conversions in both
>> >   directions.
>> >
>> > ``KVM_SET_MEMORY_ATTRIBUTES2_CONTENT_POLICY_PRESERVE``
>> >
>> >   On private/shared conversions in both directions, memory contents
>> >   will be preserved and readable. As a concrete example, if the host
>> >   writes ``0xbeef`` to memory and converts the memory to shared, the
>> >   guest will also read ``0xbeef``, after any necessary hardware or
>> >   software provided decryption. After a reverse shared to private
>> >   conversion, the host will also read ``0xbeef``.
>>
>> I think that this example is backwards. If the host writes to memory,
>> that memory is already shared, isn't it? Converting it to shared is
>> redundant. More importantly, if memory undergoes a shared-to-private
>> conversion, the host must lose access entirely.
>
> Ya, it's messed up.
>

Omg, it is backwards!! Might have been copypasta...

>> Maybe a clearer example would reflect actual payload injection and
>> bounce buffer sharing:
>> - Shared-to-Private (Payload Injection): The host writes a payload
>> (e.g., 0xbeef) to shared memory and converts it to private. The guest
>> reads 0xbeef in its private address space. The host loses access.
>> - Private-to-Shared (Bounce Buffer): The guest writes 0xbeef to
>> private memory and converts it to shared. The host reads 0xbeef.
>>
>> >   pKVM (ARM) is the first user of this policy. Since pKVM does not
>> >   protect memory with encryption, a content policy to preserve memory
>> >   will not will not involve any decryption. The guest will be able to
>> >   read what the host wrote with full content preservation.
>>
>> This is correct, but to be precise, I think it should explicitly
>> mention Stage-2 page tables as the protection mechanism, maybe:
>
> pKVM shouldn't be mentioned in here at all.
>
> ---
> By default, KVM makes no guarantees about the in-memory values after memory is
> convert to/from shared/private.  Optionally, userspace may instruct KVM to
> ensure the contents of memory are zeroed or preserved, e.g. to enable in-place
> sharing of data, or as an optimization to avoid having to re-zero memory when
> the trusted entity guarantees the memory will be zeroed after conversion.
>

How about:

or as an optimization to avoid having to re-zero memory when userspace
could have relied on the trusted entity to guarantee the memory will be
zeroed as part of the entire conversion process.

> The behaviors supported by a given KVM instance can be queried via <cap>.  If

I started with some implementation and was questioning the value of a
CAP. It seems like there won't be anything dynamic about this?

The userspace code can check what platform it is running on, and then
decide ZERO or PRESERVE based on the platform:

If the VM is running on TDX, it would want to specify ZERO all the
time. If the VM were running on pKVM it would want to specify PRESERVE
if it wants to enable in-place sharing, and ZERO if it wants to zero the
memory.

If someday TDX supports PRESERVE, then there's room for discovery of
which algorithm to choose when running the guest. Perhaps that's when
the CAP should be introduced?

> the requested behavior is an unsupported, KVM will return -EOPNOTSUPP and
> reject the conversion request.  Note!  The "ZERO" request is only support for
> private to shared conversion!
>

Do you mean ZERO is only guaranteed for private to shared? If we say
"ZERO is only guaranteed for private to shared", then pKVM could
additionally guarantee zeroing for shared to private. If we say it is
only supported for private to shared, then should I return -EOPNOTSUPP
and therefore not allow platforms to provide other guarantees?

I think we should stick to guarantees for this

* not specified (default) = no guarantees whatsoever
* ZERO = guaranteed zero for shared to private, no guarantees for
         private to shared. Platforms can add on more guarantees.
* PRESERVE = guaranteed preseved in both directions

-EOPNOTSUPP should probably be understood as "There is no way to
guarantee this" like how TDX would return -EOPNOTSUPP for PRESERVE
(now).

> ``KVM_SET_MEMORY_ATTRIBUTES2_ZERO``
>
>   On conversion, KVM guarantees all entities that have "allowed" access to the
>   memory will read zeros.  E.g. on private to shared conversion, both trusted
>   and untrusted code will read zeros.
>
>   Zeroing is currently only supported for private-to-shared conversions, as KVM
>   in general is untrusted and thus cannot guarantee the guest (or any trusted
>   entity) will read zeros after conversion.  Note, some CoCo implementations do
>   zero memory contents such that the guest reads zeros after conversion, and
>   the guest may choose to rely on that behavior.  But that's a contract between
>   the trusted CoCo entity and the guest, not between KVM and the guest.
>
> ``KVM_SET_MEMORY_ATTRIBUTES2_PRESERVE``
>
>   On conversion, KVM guarantees memory contents will be preserved with respect
>   to the last written unencrypted value.  As a concrete example, if the host
>   writes ``0xbeef`` to shared memory and converts the memory to private, the
>   guest will also read ``0xbeef``, even if the in-memory data is encrypted as
>   part of the conversion.  And vice versa, if the guest writes ``0xbeef`` to
>   private memory and then converts the memory to shared, the host (and guest)
>   will read ``0xbeef`` (if the memory is accessible).

Thank you for this summary :)

I see you dropped any documentation to do with testing. I meant to
document it (at least something about the unspecified case) so it can be
relied on in selftests, with the understanding (already specified
elsewhere in Documentation/virt/kvm/api.rst) that nothing about
KVM_X86_SW_PROTECTED_VM is to be relied on in production, and can be
changed anytime. What do you think?
