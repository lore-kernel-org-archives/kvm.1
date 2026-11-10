Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.189
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331793;
	b=KWre/ruWj54LMhXG8sMfm/wqWMR9XxSrIrj8lOpxsGhciQa3TbgyBSldJsG/iYA9+uaD
	 pDnmibRMnCfduVRtijbWkaoWLJlfklFlwFjM0BWGBuhNLCJ4uPkgRQsBl7HDMcMrnLxQN
	 +8fT07WyzkLkhYAwbX2rP4vKfRKbf8skjUkJw+yn7e3B6uxSbj5JFk2VdDtYli9FlBjiA
	 Pbbg6X2JA4zoCpDLqe/EHCG4DS+whxGwHNZDGr561Oy89h/NsKhm34ryMPdEO1ECMPCo/
	 uOGlUEHNCsKJZ/LedQo+z26sZY6adD830C/wN/YkOxBBcJ0VdscM9uu2P2WHrUXdT8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331793;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=5wx+HPVDzMK2ZNFwmp4IvNdPd/griQf8bcKEGlkTO38=;
	b=PouteXtSCaP+sttgxQvcvLJc5qASIHy82gj53gDbRGtsdYX0nqWrlBkesDrjT4zdA13G
	 yxVBuQu1zT34XK0z6kVXjsDDRa30Tmx4MTJbQ4RcIpyatZP+KTnV0Qtw8HsWDM+xxKr5w
	 6nE7GSWEpBhB9uRnMUe20h2LcbZwd+IziLXsnJYQVGEBgtzoxhTugK6SW61Qq4iOW6DJy
	 QC01r1nzbprbpTIB4UIhaOlTdeAXAxsymft/WAKZwYe8jWCC9P5k/Wgege/BXYbSTiObL
	 MOKLVAfvQnA7Si4uVhj6nS5EuAMws46d20+DBSsNj54VZHFOzD7K75iqQzpi7IOAi/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=iNxGoDuC;
	arc=none smtp.remote-ip=91.218.175.189
Received: from mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EFD606A334
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 17:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42EFD606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=iNxGoDuC
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xgvHwTGa+PgFPe0I//hfxTTphupF934nrFHnim+v1LA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794331790; v=1; x=1794936590;
 b=iNxGoDuCsXybkFz0tp2BDXmS1BvdGGx6ISeGLecO1a9j0nwKiRnb5lUp0t8/dD1ddjyvkvtE
 ZdufKCh+lnWxkCAX+UK9QBj+d5npTyJmzroQCZ2g0D36b9qvSqbvx6BcxshAthI0YzYAIldN7pv
 bcm2JMFUG7tpXwNIjtG70dxk=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 274ca47749fbff55;
	Tue, 10 Nov 2026 17:29:50 +0000
X-Mizu-Trace-ID: 274ca47749fbff55
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5c14bc5a743so12728e87.0
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 09:29:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEjckel6P7BXa+FSkqMmZTc/kz2M/oOa6YXOb+lXl5QVWlRrHYdfM5JfgSUyo2vZDXY6dQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9631QRCjbhtisWg4zNL+dHWpLy5OtFYJUG1Yyqbl6svtFLBsmH
	ucsCTs8CmvV0/Hr8jVzh403B67eoA1Ec8CzKv6KnP6E2OcWOfy6eUoEpSBusFPiEc13ZyAHf6yX
	rTR8t4z6EZ6Ul9Nj1Z67lADYR9IAIfGT01CzpmbHs
X-Received: by 2002:a05:6512:33cb:b0:5bf:f81a:f24e with SMTP id
 2adb3069b0e04-5c157dba643mr143671e87.10.1794331787336; Tue, 10 Nov 2026
 09:29:47 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110110724.3614412-1-fuad.tabba@linux.dev>
 <20261110110724.3614412-3-fuad.tabba@linux.dev> <avMoubwqgXbpflwM@gremlin>
 <CA+EHjTxT_9NghyLSZmOOi_oQboQw-g+6z9WxwaF=-7RdaGbMNw@mail.gmail.com> <avM9_7aWUDJSL3Lq@seanjc-mac.roam.internal>
In-Reply-To: <avM9_7aWUDJSL3Lq@seanjc-mac.roam.internal>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 10 Nov 2026 17:29:10 +0000
X-Gmail-Original-Message-ID: <CA+EHjTzS-=5kKVLD2tH7cvHJXK5UrMkHwHt43oGTz-LfgwnzEw@mail.gmail.com>
X-Gm-Features: AclHuK_8onLfxAou1vV3GX8Fp1YuNIw5KxweJ38CdU52leAU_A1H9EYmOqgJEWU
Message-ID: <CA+EHjTzS-=5kKVLD2tH7cvHJXK5UrMkHwHt43oGTz-LfgwnzEw@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: selftests: Test KVM_PRE_FAULT_MEMORY against a
 full dirty ring
To: Sean Christopherson <seanjc@google.com>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev, 
	Wei-Lin Chang <weilin.chang@arm.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Nov 2026 15:53:35 +0000, Sean Christopherson
<seanjc@google.com> wrote:
[...]
> Before we effectively solidify the behavior, I think we should have an explicit
> discussion about the desired behavior of KVM_PRE_FAULT_MEMORY when dirty logging
> is enabled.  E.g. the only reason I kept the existing behavior in my auto-prefault
> series was because I couldn't think of a good reason to change it.  But we never
> made a concious decision in the first place, i.e. we never considered what would
> happen if prefaulting collided with dirty logging (as evidenced by this bug).

FWIW, I'd lean towards a pre-fault not dirtying the page. arm64 (with
a dirty bitmap) and riscv already map a read fault on a logged page
read-only.

Tried it on x86 by not mapping a prefetch writable in a logged slot,
so that the fast path logs the first write. That also changes async
#PF completion, so I don't think it's a stable fix.

The loop has to stop for as long as x86 logs, so should patch 1 stay
as the stable fix? The test skips when pre-faulting dirties no pages,
so it doesn't pin either behavior.

Cheers,
/fuad
