Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8185242D9B
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 00:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781569573; cv=pass; b=MIGtj7hU0K1DC5vEIPMF+8JH03guY9WzuBNelfJgt0aCQAdSi0YO979BcajW4L9jxkn1zhZ0dUMnk7nv049EKGMVvG+pb4ofF6q2VsP5n7EO4FQ1wJOt0zUqqLk8Dmc7MKiZuRDtGMOa0L0xlzXLBfzzCPLqdLAILiOnkuIezXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781569573; c=relaxed/simple;
	bh=Koo/Jz4gLUExZ40dyzu72YS8cluJLIEkZVQM02WKK6Y=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ha1mTaFNzUyxhzjH3ITocBh+GMboZKx2UIYeopZ7WZ6ugrWlYNxx5J0qWzYRR4c48f44z36lXJtGhZMdXLv5OLqNbukitNngHjtrsdNm+L2hQyk1Ycd4OL+G7A26Dap5TV5I9KexUsYxseawfAU4jbzTipuynBfV0qzvdto9L2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ArxYcBE4; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ArxYcBE4"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-138501f8c04so1887637c88.1
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 17:26:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781569571; cv=none;
        d=google.com; s=arc-20240605;
        b=a35mioHJcSFLpL8yUcgoxbF65RfTltuTfQ1Yz2OY+D54HC3NJaMMJjozt3HcQ8jVvK
         sWCfYyExSor1sShLj8mPgiWmtVUmPl0eV0X9Z38A+XDbWJ1rL2WP36KuH3HgkQSo9KxC
         5VGXj8iQ/K3FKIuFr8Wxg15QIzMMySd8imx79N9GfJdvLLLSNUueOClTbxlgV8hk0+dq
         w/n/c32M1RC7CghG7T7nGsSj864qOTYtY5WlHfFcbB852OjUg+t0SsgPIp8HdyJL5eUE
         E3JDLqmRtfriVA93N/iM9BZ0Olsn0NO8fXKOVH8p7u+M+R+t1wdODsFCIM/BFOQ8ApIg
         prmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=tE+C1LABhu/HpTkLPZGmRp5SO8S6COXMT4jaz0dQqLY=;
        fh=k19NUBZoHXNWi0V2PqnkDwMygHLdCs+MCgg3INfQmOA=;
        b=X6Tyj/KnCx0JjpbZPNtFsHkyMQpfACDETTl3OIoSaB1l8MN4q/XuIHq5c72Nk91u3W
         StXTbHGTFjE+ra1/A2RJVpDllD3hKwnjYRCe1TS6Y5LsOvD9cgUQEPeym4e1sIONTvs1
         yHZ9xXqgO3UlRTzpIFcrY8+2pk0ENVKqrSLQQz+TLT/z057GlpNpRsIW/U+Cfad5POBJ
         2gkjub8tlmPqiA+mJNg7hFgeUElNlEBh38kwPSd3bS8VL+FTTLUZRYWHIm1L8ic+xlmG
         0di3FuBHcvt2i39qAEiVTwDM/gcV1pUoveK+tuOyg1VQhM+7khxz45KU/1uCnADazvWX
         5VCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781569571; x=1782174371; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tE+C1LABhu/HpTkLPZGmRp5SO8S6COXMT4jaz0dQqLY=;
        b=ArxYcBE4vDTUIJR4q48gNmk9WOq8zo7GAdcoxEnbJCxlPgNgkfm7y2xSu9AndEpO8h
         rkF4NLVjQG5RlClUzwz/F8C4ypfHIhiB3eZYX+Afo4W5g1g8yBHve4U8Xr3h5dY0WIOm
         VVylNAiCDZ330Z35iL1stNvhHhqlCUgPUp7dZF4TlkB/douCGyeePQ7OXW+d7YbqfYuA
         i0tdQTm7NvDkv1TCBHvCLkcP++tIqQQZBBJI+UF6AhfgNW3z2uu2iVEnr6Z35Edn/x20
         GvaelLOm21qcgfaYsexYiM76LajyTZEEwZlWSQEpzUeVO3Vscyl7RkLbGQnvGn9uedv0
         KZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781569571; x=1782174371;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tE+C1LABhu/HpTkLPZGmRp5SO8S6COXMT4jaz0dQqLY=;
        b=l6s6e8PKDm1yM1Q0KHJk91WmLo04FYIi1LvEuIxvYbWFCt9LTVHr1TIjSBzmPKxOnK
         9r3dqT76k0A+NiffZkEtxNdUPPCVxXHxhmQFoBY0Xb8Bj/5KMUlZdX9D8+WSLBnb7pQB
         CIvqOUi8qzEqeI07vlBQqsorPZ4SwHYoj/nK45gavcefhRq0hUQpeW7BengXfwSu2r9u
         APZ+gzyQn1/o1ZCJMsRDLc9akR16f7f6sv3N5n1ad95oE3wGwRgE0exufinQ/FCv+5ds
         KGsDx8kiEFw2e3ml97WBLgXaInTQR3nZxjTWWj6wVW5QQycCxKTlbbdGC6gTnIXXpir6
         OAVQ==
X-Forwarded-Encrypted: i=1; AFNElJ/G1S8NEqQ6zKNU1hHeyNp4LO0EB6fidKCAXJ8COqXHpziOneo98+3ywnVZ+JBh6jMnlsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnDAfiP38uw+wAH9Ni8jZ5CWiWGebTD/Qf5BnaJG+Ixpaol7vq
	S2rJ3BsO60qrOP57JRAS/bU5N/nClmWApadvRbH5vdWRdtukl/DZ+/VTRN4B98Zt9Civqt4ob4u
	jIeKr/phnqMpPjD31ddhO4+JkViIJOldSv0Gj9GmL
X-Gm-Gg: Acq92OGCySbccWQUrBA14NnoLySSfkqtJoniJhce6v65CoNWhx7xdIweVI+2q7Vvweh
	jnu8Lsx/zr0bYTPu9og3GQlViSG0w4kvjXpAE7aH1fTsUZghqJ2TlB7GXYeTUtXCqup+oL8k2KZ
	0sHr6/NkriiwnI90Fv5EIvqIyNyKAqxnjD0uJXS034AaYLS+MDBlWnZh5F1CwPxlz3z/vT8/CKk
	s10gn8BgbKVS/lFcIwvW0eqtvY9Uva1n6ER5XT5zQCpZwvjMr4RYpQibUeHqSvSw/jpQHBd6G/3
	AIbnIy6QAyb+o+ZTI4hQlaKjLrV4D10P7Ml9Pb0PwTTxqsj9yun63Rc+ABZ3E5wsfZL8
X-Received: by 2002:a05:7022:baa:b0:138:407c:1d17 with SMTP id
 a92af1059eb24-1387901cbb8mr5193106c88.33.1781569569627; Mon, 15 Jun 2026
 17:26:09 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jun 2026 17:26:08 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jun 2026 17:26:08 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <aiM2Nm9Eh68mIVX3@google.com>
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
 <20260521-tdx-selftests-v13-v13-19-6983ae4c3a4d@google.com>
 <CAEvNRgHEq-hHcTivUw8TYBeMu-RpS=Ho4DXaNXKQKLPL_biTgg@mail.gmail.com>
 <aiMOWkiVBqoQDAPd@google.com> <CAEvNRgF09SfDm=OgbrS8-wpfxbNecQkqAQwf1ELq1jWu7NjbUA@mail.gmail.com>
 <aiM2Nm9Eh68mIVX3@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 15 Jun 2026 17:26:08 -0700
X-Gm-Features: AVVi8Cc5zceSfwq1JSECSJwoz8IcfIBykP9G13fuyk-9uS8vJvNRi0GOVDWkEoY
Message-ID: <CAEvNRgHjno=XDnMpTvZcNCR6D5RAi1rbynrL4CnnEa7Y-M3VLg@mail.gmail.com>
Subject: Re: [PATCH v13 19/22] KVM: selftests: Finalize TD memory as part of kvm_arch_vm_finalize_vcpus
To: Sean Christopherson <seanjc@google.com>
Cc: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Ira Weiny <ira.weiny@intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Ryan Afranji <afranji@google.com>, Sagi Shahar <sagis@google.com>, Shuah Khan <shuah@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Fri, Jun 05, 2026, Ackerley Tng wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>>
>> >
>> > [...snip...]
>> >
>> >> Was kvm_arch_vm_finalize_vcpus() supposed to be for finalizing vCPUs
>> >> instead?
>> >>
>> >> The awkward part is that kvm_arch_vm_finalize_vcpus() is called from
>> >> __vm_create_with_vcpus().
>> >>
>> >> While building this POC to test conversions [1] I only wanted to create
>> >> the vm and vcpus and didn't want to finalize yet, since I still needed
>> >> to do more mappings in the guest (and I needed the vm pointer to do
>> >> mappings in the guest).
>> >
>> > Hmm, I would argue this is a flaw in the selftests infrastructure.  IMO, as a
>> > developer, it's quite surprising that the current value of a global variable
>> > doesn't show up in the VM automagically.  I totally understand why selftests
>> > work that way, but it's certainly odd and annoying.  If _that_ were solved, then
>> > the kludginess of what you're doing goes away.
>> >
>> > The other way this could be solved is by adding support for annotating globals
>> > with a __shared flag, a la the kernel's __bss_decrypted, so that loading memory
>> > into the VM can automatically mark the associated globals' pages as shared.
>> >
>>
>> More generally, is your opinion that tests should not have to add extra
>> memslots?
>
> I don't care?  What I care about is making it as easy and intuitive as possible
> for people to write tests, and to minimize maintenance costs.
>
>> If I wanted a shared page, would I have to do
>>
>>   static __shared test_page[4096] = {0};
>>
>> and then rely on ELF loading to put that in the guest for me? Are there
>> some compiler flags/how will I require that test_page be page aligned?
>
> Compilere and linker shenanigans.
>
>> If I mark 10 globals as __shared, would the compiler automatically
>> consolidate the shared memory together?
>
> Yes, follow the __bss_decrypted breadcrumbs.
>
>   #define __bss_decrypted __section(".bss..decrypted")
>
>> I think it's a bit constraining to require that all guest memory be set
>> up statically. It's nice to have but I'd like another option...
>
> You do have options, they just require more work.
>
>> Many tests use vm_userspace_mem_region_add(), CoCo tests that require
>> finalizing shouldn't be disallowed that option.
>
> What does that have to do with finalizing the VM?
>

I could add more memslots after finalizing the VM, but then I'd have to
make the guest accept more memory. Hence, I'd rather set up all the
memslots and then finalize the VM.

sev_smoke_test currently has a separate vm_sev_launch(), which is the
equivalent of tdx_init_mem_region(), and that's called in the tests
themselves.

sev_smoke_test also uses vcpu_args_set() after creating the VM with
vm_create_shape_with_one_vcpu(). Would that work if vm_sev_launch() got
moved into kvm_arch_vm_finalize_vcpus()?

>> >> It's also possible to have some kvm_vm_finalize() call that can be
>> >> explicitly and manually invoked from selftests just for CoCo selftests.
>> >
>> > Why bother?  It's obviously possible to all kvm_arch_vm_finalize_vcpus() directly.
>>
>> Works for me to call directly. Do you mean kvm_arch_vm_finalize_vcpus()
>> is the right function where the TD is finalized?
>>
>> For tests that need to do more setup after creating a vm, is the only
>> way out to call __vm_create() then vm_vcpu_add() to avoid premature
>> finalization in __vm_create_with_vcpus() when
>> kvm_arch_vm_finalize_vcpus() is called?
>
> Depends on what you're doing.  Sometimes, the answer will be yes.  That's why
> there are "low level" APIs, so that some tests can do fancy things, while most
> tests can leave the details to the infrastructure.
>
> If there's a recurring problem, or we anticipate one, then we can and should
> figure out how to minimize the pain so that tests don't have to deal with the
> same boilerplate issues over and over.  Hence the __shared idea.

I still think kvm_arch_vm_finalize_vcpus() is an odd place to be
finalizing the VM.

I would prefer to not have to explicitly call some function like
kvm_arch_vm_finalize() (no vcpu in the name), but a common arch function
calling vm_sev_launch() and tdx_vm_finalize() is what I can think of
for test setup flexibility, without too much magic.

For now, I can't think of many uses of __shared. ucall shared memory is
allocated dynamically, and we can also make it shared cleanly within
ucall code.

The global variables (sync_global_to_guest()) will appear in the guest
as long as sync_global_to_guest() is called before
kvm_arch_vm_finalize(), which I think makes sense to people writing
tests for CoCo.


So 2 questions to push this along:

1. What do you think of a kvm_arch_vm_finalize() that calls
   vm_sev_launch() and tdx_vm_finalize()? My key issue is that
   kvm_arch_vm_finalize_*vcpus*() seems to be for finalizing vCPUs
   rather than the whole VM.

3. Would you like __shared implemented together with this series, as a
   prerequisite, or later?
