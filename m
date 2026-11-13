Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577745;
	b=yH+wf77I77sQbUkPbb8Zei5gruO8+y849DOhwkHt1RSz6z1YlXdKk760E5Mg9QBtjy5Q
	 toK+gF+o81chOCeCjOFeRdqpAwEVvnJFdqx0QYcWvCTji1PFe4E6fHyjkNxOPUKW+k0A7
	 jhREMFs70KkMNo7rnBod3r0qpXK0Vc+dA/3VPrlBSE7C08QpdJ+rSg+CO3QEoYkl1VGYh
	 onVi8OnlDObztb9TyrufZbIc1xtWCrZoXbr/UBtpi1Sd0R0YpNsWsqSWENPw3OW/RXjC/
	 vzWvYA+uaHee+cWKjtafvvun1Q48mFVn6+AQSyrqaEWEHI+W67jqE665qE7hs3RvB4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=grVGPzydbdmfpJ8vlKQ1lGDL1axSE+48g8mGBT9KboM=;
	b=CKIk37PybQI6klaXiIDfJAGEgzt9DsRiuppVS/fWY+Ya4nyXw8Wm/KyHbMTEx9tw7fw5
	 4P4KIbvt+edqEtQCAqxDs9qq3L/mn1M/JGXD8ZtvdTSur5pYWrVMrG1mM/iFg9UuXHMkt
	 cnyUXWDVlaGhpfq2ewA26Plal+m9Os5mthfimlDjBl8+gl5Cn+JU4An6Yxl/AdIaJTqId
	 0KItuPKvxT4jJSz8O6SpPP+KHiv2gHqGgX8S1C9nMivuVFU8sYvTg3YoxTpX87TmXzKTO
	 wjzJKNR0k/A0NHwh9xQKIBvPmpOkURnLC0EInmd60e4pl3KqbtJjGTb9C6anDhpDxcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mtszKlaE;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87572606A8AC
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87572606A8AC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mtszKlaE
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ed2c307e62so17408715ad.0
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577745; x=1795182545; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=grVGPzydbdmfpJ8vlKQ1lGDL1axSE+48g8mGBT9KboM=;
        b=mtszKlaE+mXwg2j8jwSWBq6bfVInX7Jz0gO8y6f5j7WlfX1lYOBwGBLXtiUT9e1s9/
         +gLm6EBwrEKgIX/JnepZARgLtLZoAbg32wt7rpN+C3/AjG/2KaRVeR8F3rIQrLv8RmtP
         XrZgcvLaQkcpcO5i7AbvjWva58q+DJMXl3XGpCu4GclObVXsSoxlZ73+UvXSUKmC+wD9
         E+xO8HV+OAiVpzeU+Go9glChei3r8kznD6Tnqem9qAj/sCnr7Z37NUdJ8W8z41sF4d9b
         XYm8neYGzRR1q2PanTLisCh6cN2XtJA37xDYHoeDHDXNMbM/80lZpK7qU15XRFUIDhv2
         lldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577745; x=1795182545;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=grVGPzydbdmfpJ8vlKQ1lGDL1axSE+48g8mGBT9KboM=;
        b=YjyRxWx/RhN/Gt/CibZOcNM41GA3IDVBOPjUlMa+kWAQ9AM3e6Y+ML+ajIFP6LNlCs
         zaOVCIr9cSKzgYaiGWkXYhUDldg9fjF35690oeeA6/hIHghkogI7dsxNQ/uFc9jpOtLl
         s+2xTJamwzPplueaCGQI6u3/NBRoG4tyj2MpcHyME6+auyuYAyRuRkkoKDj6iVJX23xr
         SbkTI6/C+KI28FfG6tlEuIapeOCXQ2SE9bYznbjLS5ZfNtOceTIaXhCZHeLxl+lsvJjb
         5kTzyr/R11rSDrAtDhUF9taz/F/J3xLVfJNkzt7kTOnUqgLTpQWLoqhKZHGL72WOAKUl
         BktQ==
X-Gm-Message-State: APuU4Z843YzzidZYqLtKvqInJPzK3wHnsoad8uvAlPUwCL+vwBqk/mJ/
	VFuJNK589mjfZznvoCAtdNnhCWObSo1te1ciw5TCGJrP2twbLgX3wAerUVPZyilLgMlz6wRcTEt
	cJrktJw==
X-Received: from plwp1.prod.google.com ([2002:a17:903:2481:b0:2e8:1aeb:b4c9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2283:b0:2e9:8b2f:3561
 with SMTP id d9443c01a7336-2ee0dcadc6fmr25461925ad.54.1794577744651; Fri, 13
 Nov 2026 05:49:04 -0800 (PST)
Date: Fri, 13 Nov 2026 05:46:36 -0800
In-Reply-To: <20261109212248.996736-1-alejandro.j.jimenez@oracle.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261109212248.996736-1-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441797988.78239.10997618370883122888.b4-ty@b4>
Subject: Re: [PATCH v2 0/2] KVM: x86: Fix physical APIC map routing for
 aliased xAPIC IDs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, 
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, shuah@kernel.org, 
	partha.satapathy@oracle.com
Content-Type: text/plain; charset="utf-8"

On Mon, 09 Nov 2026 21:22:46 +0000, Alejandro Jimenez wrote:
> Fix physical APIC map routing when an xAPIC-mode vCPU with an ID above 0xff is
> created before a vCPU whose ID matches its truncated xAPIC ID.
> With KVM_X2APIC_API_USE_32BIT_IDS enabled, the existing alias entry in the xAPIC
> range can prevent the lower-ID vCPU from being reached via its xAPIC ID, and
> result in incorrect delivery of INIT/SIPI during CPU hotplug.
> 
> Following Sean's proposal [1], always allow the vCPU whose ID exactly matches
> the aliased xAPIC ID to install an entry in the map, even if one is already
> present. The full-ID (i.e. x2APIC ID) routes are still used to reach the
> higher-ID vCPUs in xAPIC mode, preserving KVM hotplug behavior.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/2] KVM: x86: Prefer exact vCPU ID matches for physical APIC map aliases
      https://github.com/kvm-x86/linux/commit/a64b916ef22f
[2/2] KVM: selftests: Test exact vCPU ID matching for aliased xAPIC IDs
      https://github.com/kvm-x86/linux/commit/a6d590ba95ef

--
https://github.com/kvm-x86/linux/tree/next
