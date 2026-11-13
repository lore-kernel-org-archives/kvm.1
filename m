Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577959;
	b=TN6ORKIhi8ec0IFhf9VnBfkzi0Srvimx/tpR9jC8uGAVdA6HYYUdNnrSZ6whCN06Jiss
	 vz5h9HXTgaZ//UzNSgWpM2KUlcGVR58Ci8UnG9Tc6XbmLCLdzlMxJSBt+tS3Ta9gJxPXC
	 rleLUdWjTVF4lAW+d5GBGBesbKWoYcfDhQkR9Qko0weHVage+yX2G0rRZQ9rkfNx7CSQt
	 ApFZoA3sAE/p/p4eoxKKlYHVZHhktdyJZ+zSXsAAhp9waQAs0FjZOKs067QjXZiwJuGYv
	 PFptmfqkHhnJxxWXo3iKs7eisq6jW0jmgy5bswmyksEaYEdEGR0bVTimhngvPEUJ5/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577959;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=W/F9G60O9NvWaV0JAVRe4F7GQSW7jUltp7CvrY/n2ho=;
	b=dZz1eDbPMJH7IdctSsTJzNYkMEdEZH735MH63phcTGQ7/jhTmYY0sXYTFCAIDmw582eo
	 1zW3Sb8WCwxUiGIjxy1b+JCrHa9uw/Zg1nFqPBDAwfnjR6Hv6Vvp3xoD9/3K4QHL2oGsL
	 FkOUSGiHnMLtKcHKe5Y3HJU/xWKj/cKtudGqC/HddFaPwAIoh0rz8xDlY0sVsXi56zbWP
	 Elf0zD0r94/VqnrR8BiNUmyAmYP8UhuPUouPqtjoCffzT6mzQpW9dGSOiy+LIO5gS+VAS
	 WCf95vGXQ99MDKnC+ziUexUFoCtBs1SoRFHSl5Jlp1f+6iHnUTjx9mdlaXotm53B+lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JPmDdMYw;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D84606E0E4
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 13:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47D84606E0E4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JPmDdMYw
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2eaf8ea208bso8225385ad.1
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 05:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794577959; x=1795182759; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W/F9G60O9NvWaV0JAVRe4F7GQSW7jUltp7CvrY/n2ho=;
        b=JPmDdMYwKhdw6kPoXM33yGFo+OD4c/WKvBLp3tNjkF0fCOKQkd4r5wJwVeLSuP2PRB
         s/+SnxM4GqdiYqNT4B3b6ol7ERv1sIy6l6T4cjoIhn3Vi20Rkte+4PSHPC6OND0+avnu
         RrDCE4IIbU2gApI3MudDCb6dIhNISX1ssu5rBEv0Ljc3KyekvoGPU7GvVv+tsbBjjy0l
         lFY/gZIlJbk1PHsJ2PM/No4IfUSzc4qEteoQ1PAu4H7uGTnrjbLAOT15d/hOWE37i8LF
         qua8c1MPggAxNEjbMERP130+4OTwZd5T7O8kvASwlLnrFwWUfH+urjCuUuS1B4cjDFRY
         VU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577959; x=1795182759;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W/F9G60O9NvWaV0JAVRe4F7GQSW7jUltp7CvrY/n2ho=;
        b=Cp6M9/6xNrcS9/UKQQlEcK++hmoGRIX01XKuUokHubw/v6N3FN2P9SdPRU1mkY16QK
         vEke3gipTXy9iXDgabLcbekf5o+i2Wrk2ByRhVuo1gq/e3Bfdw2WOxinLbogcdC+Xvq7
         rWYVQFBFCtgDghlUwWRMBA+G7rnvlZKM+LGFlPlA4haRsK2Iz2GqBva0e6hm6WV6rwIV
         mdt4QEDC9JydJcW0v0VOgWiyY+aivNqmf2O3NMCODXKFRiPj34+1VP6DFZXTwG9Tac5z
         W9/0VN6JPiNqNHcAJmHols74hl6lAp1NGhjN7nMff1TorXsUlZveQ0N3r65eU9Tp9WnF
         Znhg==
X-Gm-Message-State: APuU4Z8JCMt88TN4EqQLM/TSueE/jzuuK4uEXz6naHtAdsrYqfdQ4vMK
	GTryr6S+MymsYG6CkQPx7kJKlP7lkWLVCrXrK72TPlim0ZlHNfoAB5wLrBAZ8XPG/4a0hvbD2Gn
	UYKu40g==
X-Received: from plhv13.prod.google.com ([2002:a17:903:238d:b0:2e8:531a:afe2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:984:b0:2e6:c39:b25b
 with SMTP id d9443c01a7336-2ee0da7f5acmr24740045ad.14.1794577958454; Fri, 13
 Nov 2026 05:52:38 -0800 (PST)
Date: Fri, 13 Nov 2026 05:47:35 -0800
In-Reply-To: <20261105181742.3718448-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261105181742.3718448-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <179441816397.79742.2627638258481171996.b4-ty@b4>
Subject: Re: [PATCH] KVM: VMX: Re-pend KVM_REQ_APIC_PAGE_RELOAD if getting
 backing pfn fails
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko Bot <sashiko-bot@kernel.org>, "=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Content-Type: text/plain; charset="utf-8"

On Thu, 05 Nov 2026 10:17:42 -0800, Sean Christopherson wrote:
> Retry loading the APIC-access page if getting the backing pfn fails for
> any reason and APICv is enabled, i.e. if the vCPU will consume the value
> stored in vmcs.APIC_ACCESS_ADDR.  Dropping the failed reload would result
> in KVM running the vCPU with a stale backing pfn and in all likelihood
> break APIC emulation/virtualization.  E.g. if KVM's page tables are able
> to map the page, then guest accesses would go to the new physical page
> instead of being treated as APIC accesses.
> 
> [...]

Applied to kvm-x86 vmx, thanks!

[1/1] KVM: VMX: Re-pend KVM_REQ_APIC_PAGE_RELOAD if getting backing pfn fails
      https://github.com/kvm-x86/linux/commit/65af5b974fee

--
https://github.com/kvm-x86/linux/tree/next
