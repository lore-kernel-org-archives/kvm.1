Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577892;
	b=IhwsgORRjNmDgNIoW4+LM9/+3WKkinAb47ujg0+OPKjccm8M28tYsJ9H8jgX9njdidjl
	 nMUsMt25/MZlofUUV/Ysa5RhWmJ1tBa0MGjXbSja/LT5EzoXL04TkoNQDUFro5K9f0fSr
	 IWwV8wO7LOKFRuZcd5ei+atP1yxuYaQs2rIi2m2nBWm8bWv/3Qj2Iv9EPp99ybRPCBJ1G
	 iaRCfoLBK+UZTZkaJUAUfXFSXTtetY0PkXtaKymTJEjdCmRDgyzPx9ndnIj8RhhMoOsLy
	 McHj8OlVZwwWqdC/dlCHRbEhM6kB6SS8blaYwMEWVeb1NGREbVqEPerVR69U3lMCl0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577892;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=HXcFqkyCwC/scABn7YnbJt7nSVqNX1uskRy4u0MJf40=;
	b=ppfPZ7LK//QPLgMV1nlc4A5gh64bhu0PBDJ/Fdy5AXEKU1oa8dRnJzVCyvbz8Uo5qC+b
	 fFgKo7dqM+1+7Qopt7gbMWSdp7MDvDlg+L43Sf/5Kv94mdWMWRIPJgHzGXI1J16x6xoss
	 KujK6eukshhHWUEf97+yHPqeZzGc0JMMLUoKPS3JAeOOAiqChF0QRj+8Ov+ryqjRwfL8i
	 LTPNHXqO41eURRA+ICTIEq42Culiin4SbLV/kVd62+1P/+4tr9hWT/fjaflHdThfasnA9
	 0+uF55apCE3OQ/Lb8UczKpf289Uptwa+ulchL4Ga1D4AYNQFIUQTJRjtFEONTLxuzlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SndIOSdP;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486DC606B1A1
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 486DC606B1A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SndIOSdP
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ea71803effso9448145ad.3
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577892; x=1795182692; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HXcFqkyCwC/scABn7YnbJt7nSVqNX1uskRy4u0MJf40=;
        b=SndIOSdPwggsbjvq+DliS7h/mRVdS5Q/G999q+LMu6Hk6k7RmnKb1cAS92Vu4Vljyd
         vCbJqPj/SlzkIRreTZA1sTFleRg4XzrqAoXZQK1wxTw3BVTjFgQF0eMuSxmFM747MR64
         PYQ6giTPgza4GVy+LfbtrOobCd49GA7mbf2vhtYXLDUvnDIXLgSNRerV7wl9s2j8Q+N/
         WZcG+0kB5EtTIEoobcefae9AQEhD02wqf+aXSUiq7sbTCdH8h8NJFTT3orBn8AuMz36W
         Rc3pt7votAEHxYK4NWhxl0dNZNahXeHtry/WVoiHWF3tXFVxhikyoN/abm0a5m3vdLnN
         lpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577892; x=1795182692;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HXcFqkyCwC/scABn7YnbJt7nSVqNX1uskRy4u0MJf40=;
        b=QrIvzlL4Mf4sPJYMuspggvUUl+7GeQLB1NcJDFVftrE+/c1oflv0F5Fx/khaCGVxKY
         u3WkZ5gHuODAgh95F/pyanjTsjkDhu+7VBbT3oaXhb+hNKgok1XNUKqXMRuvIw1SZY0W
         Y8XMaqhHaDjGPVrTtM30ooiYKjLDJk8vmDBc959tDo0LCNKlL0cKDwkpx9js/Rh8N8A0
         wfpPMO7xGNek7FuqZBqxK//xvIpNx84wsYZpyB5dTsheh9TC/9kGfqrRoMy6TUoi87bS
         ZNBLKKm/J1LYfxtKfJvFxo8+Mz8XWkosYDrdgPprpxDlU0QawIvyv5piHydL5/AuVfRv
         krKQ==
X-Forwarded-Encrypted: i=1; AL+hErEHe3hhAQ9+/iT5cSduleepSLhOlYAr6qISA1k/yT+w/oi9TXM5stwtJfm9EJsqIZi/Slw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9OVwcJgPIMrmTRxlsMwaKDFZuFa4sZwzOxx+FR39IXxxWRmGKy
	AwTGfGic+EPztj4rYq1W6yYV4x6g/RDviyFzQqIZst+OIm7G2A2XETsmwfVlNHRlD1/9JK/E9jW
	p6XDW4A==
X-Received: from plty11.prod.google.com ([2002:a17:902:864b:b0:2ea:f122:5203])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2408:b0:2ea:778e:8652
 with SMTP id d9443c01a7336-2ee0dc93dbemr26695325ad.14.1794577891435; Fri, 13
 Nov 2026 05:51:31 -0800 (PST)
Date: Fri, 13 Nov 2026 05:47:12 -0800
In-Reply-To: <20261105-tdx-selftests-v16-0-2024e8fa517a@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261105-tdx-selftests-v16-0-2024e8fa517a@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441802621.78886.14787732299465308597.b4-ty@b4>
Subject: Re: [PATCH v16 00/20] TDX KVM selftests
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Ackerley Tng <ackerleytng@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Ira Weiny <iweiny@kernel.org>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Ryan Afranji <afranji@google.com>, Sagi Shahar <sagis@google.com>, Shuah Khan <shuah@kernel.org>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Oliver Upton <oupton@kernel.org>, 
	Andrew Jones <andrew.jones@linux.dev>, Lisa Wang <wyihan@google.com>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 05 Nov 2026 23:46:44 +0000, Lisa Wang wrote:
> This patch series focuses on setting up a TDX VM and adding all code
> necessary to run a basic lifecycle test.
> 
> Unlike standard KVM selftests can set up the VM through guest registers,
> TDX module protects TDs' register state from the host. This feature of
> TDX causes problems on VM boot state initialization and the ucall
> implementation.
> 
> [...]

Applied to kvm-x86 selftests, with various fixups.  Thanks all!

[01/20] KVM: selftests: Add macros to simplify creating VM shapes for non-default types
        https://github.com/kvm-x86/linux/commit/c2033e19e435
[02/20] KVM: selftests: Update kvm_init_vm_address_properties() for TDX
        https://github.com/kvm-x86/linux/commit/14a02e43b463
[03/20] KVM: selftests: Initialize the TDX VM
        https://github.com/kvm-x86/linux/commit/b025bec48e28
[04/20] KVM: selftests: Expose segment definitions to assembly files
        https://github.com/kvm-x86/linux/commit/8f2123548d66
[05/20] tools: include: Add kbuild.h for assembly structure offsets
        https://github.com/kvm-x86/linux/commit/6661b422d6fe
[06/20] KVM: selftests: Introduce structures for TDX guest boot parameters
        https://github.com/kvm-x86/linux/commit/72643c4ab9f0
[07/20] KVM: selftests: Add TDX boot code
        https://github.com/kvm-x86/linux/commit/1b46806fea4c
[08/20] KVM: selftests: Expose functions to get default sregs values
        https://github.com/kvm-x86/linux/commit/67dd56f4f841
[09/20] KVM: selftests: Set up TDX boot code region
        https://github.com/kvm-x86/linux/commit/88a23d1703b4
[10/20] KVM: selftests: Set up TDX boot parameters region
        https://github.com/kvm-x86/linux/commit/b86c78a4b546
[11/20] KVM: selftests: Require guest_memfd for TDX VMs
        https://github.com/kvm-x86/linux/commit/ab9e3c679b35
[12/20] KVM: selftests: Call KVM_TDX_INIT_VCPU when creating a new TDX vcpu
        https://github.com/kvm-x86/linux/commit/f347a3c84cfc
[13/20] KVM: selftests: Load per-vCPU guest stack in TDX boot parameters
        https://github.com/kvm-x86/linux/commit/65d1a3c322bf
[14/20] KVM: selftests: Set entry point for TDX guest code
        https://github.com/kvm-x86/linux/commit/edc0212274c0
[15/20] KVM: selftests: Add helpers to init TDX memory and finalize VM
        https://github.com/kvm-x86/linux/commit/8d6f19adc15f
[16/20] KVM: selftests: Load private memory and finalize TDX VM in kvm_arch_vm_finalize_vcpus()
        https://github.com/kvm-x86/linux/commit/e8414d36fa14
[17/20] KVM: selftests: Add a helper to issue TDVMCALLs from the TDX vm
        https://github.com/kvm-x86/linux/commit/6c477f8d23b7
[18/20] KVM: selftests: Add support for per-VM ucall ops on x86
        [SKIP - effectively squashed into patch 19]
[19/20] KVM: selftests: Add support for TDX ucalls, via TDVMCALL_REPORT_FATAL_ERROR
        https://github.com/kvm-x86/linux/commit/0c350dc88dea
[20/20] KVM: selftests: Add TDX lifecycle test
        https://github.com/kvm-x86/linux/commit/d0926be36474

--
https://github.com/kvm-x86/linux/tree/next
