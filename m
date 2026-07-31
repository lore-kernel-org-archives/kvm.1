Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC47D38229A
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 20:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528713; cv=none; b=tUzIt0fhgKDi9jed2eUd9Ws33qgYOp6tJ1ZqLXKRHLYPF8JUViOz58rShhKk0xWA9/4eJItTmQnbPFQtNyveX0x47TP6DwjXx2VlYhc5/KkRHkLjNWNbiEg+S02elbj/3gxEuKRMXcn4GUyvdTIbd4+jBJnJq1yMBde8uUy2Mrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528713; c=relaxed/simple;
	bh=Db3mdvMaHRUiMUCFH7rsGHgUlVEuwPKkCSHT2bSVqos=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Unf1qml3t218iWnFJ9WPiVYHc91fDxzP7cqlmFPUN1MqH73zNyDO2nGXLL1PasoloRFbYy9fLY9VU+b1xarNr0w+PYNLcqftQ2VHbMeXhuk2Xf4Ds/Y7OB3xWRzgWQ64cSdr0/DpxB2g2a4c9RSpGFslltNhTksA3L3K2jmpZcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ivUGsgkX; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ivUGsgkX"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8484ba00601so1697242b3a.1
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 13:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785528712; x=1786133512; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KwciVqmU1E+FOM/kcV3bDOj/AK72EAiYVE9xetCtvi4=;
        b=ivUGsgkX/attFUqbZENaSA/Y2cIYvR/NRj7byxCvUeE6VRjjAkQR9yaUVV3EkkgQWz
         39GtJizsF2UI7I5CG5H3NJEbJ18qng7WQBGnj+woSXWxoW4ypJJ/81RMquDhx7K913TK
         WL4E/T3D4AvF7594dgbxJsJOc89tDHnTmAn3yQ3xM5w2NyBteKhaEe2TTiSSxCL6xwP8
         j7pl29rEoVuCRSS43ly9b2gxAZHGyz96CSfznPcB2pzobLIEYGDjwT22fNMBtZLM2suM
         LbgXhb/UQEOv3uyaLlnG3Ijli3xZXVLkKP3ZHPkXFpng9e7zRTdksUsui4H93UYG9Fj0
         YGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785528712; x=1786133512;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KwciVqmU1E+FOM/kcV3bDOj/AK72EAiYVE9xetCtvi4=;
        b=MiGr0fHJu3p5xsdTtB7mmZdcaVnnXWAAHadcIaV02XjTdxG/QXaDcKtyVQ4M2/io4A
         UvpvcFsyLrU39JXv9Sbkd3EZv2B4cwpCeQwKbaMy5vgqq2aCG9rQuq6VgczBsL76hle9
         bQ+joH5bATjWgJewjawjyeTmVetRrzCMkMx3EBJz2c+TPyq4q7V9BmIc3GfBkIMsKYLl
         59IENPhe3LFzA1ybDSt3CbRpujW8kVcWsE45NcarkiXJ8+8bhI1VdKVyPu/s504M7qPY
         EUsgh5CuuFTKx96trjHaB2iQDcAfiObkIPWyAagmooVziBS2hyK4iv1CJ9Ww/tF/7xA1
         J5BA==
X-Forwarded-Encrypted: i=1; AHgh+RrtY/gHIAqd+akr6ArIjiWkDucoGVfiyCxwhdtSlr2AuxBpxPoeNF7nRe1gNZPCmMqVtiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx3RJ5ZguwCOtJlKb79J3iptNvbHbL24h9vl4z07XQnA/pHNvh
	nx6mb0Dpk2w4UlzQ3iVGdOWC/EJdFBZeH7PRuxwfV7QhAvCK4Rt0zZVd73Ylwo7CyWkXBRIXVvw
	FZu1ugg==
X-Received: from pfblg20.prod.google.com ([2002:a05:6a00:7094:b0:84a:3b69:a287])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4b51:b0:848:438d:3665
 with SMTP id d2e1a72fcca58-84ee48bcd15mr763440b3a.41.1785528711875; Fri, 31
 Jul 2026 13:11:51 -0700 (PDT)
Date: Fri, 31 Jul 2026 13:10:13 -0700
In-Reply-To: <20260715063626.65899-1-pankaj.gupta@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260715063626.65899-1-pankaj.gupta@amd.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <178552837642.2712144.16765082260306461300.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: SEV: drop FOLL_WRITE for encrypted region registration
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, tglx@kernel.org, bp@alien8.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, 
	Pankaj Gupta <pankaj.gupta@amd.com>
Cc: x86@kernel.org, thomas.lendacky@amd.com, hpa@zytor.com, david@kernel.org, 
	yangge1116@126.com, ljs@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, 15 Jul 2026 01:36:26 -0500, Pankaj Gupta wrote:
> Commit 7e066cb9b71a ("KVM: SEV: Use long-term pin when registering
> encrypted memory regions") added FOLL_LONGTERM to
> sev_mem_enc_register_region() so anonymous guest RAM is migrated out of
> MIGRATE_CMA/ZONE_MOVABLE before a long term pin. It also kept
> FOLL_WRITE on the pin.
> 
> Combining FOLL_WRITE with FOLL_LONGTERM breaks registration of file-backed
> guest memory, such as virtio-pmem host memory-backend-file mappings
> (MAP_SHARED). GUP rejects long-term writable pins on dirty tracked file
> mappings since:
> 
> [...]

Applied to kvm-x86 svm, thanks!

[1/1] KVM: SEV: drop FOLL_WRITE for encrypted region registration
      https://github.com/kvm-x86/linux/commit/ee1a586dd1fa

--
https://github.com/kvm-x86/linux/tree/next
