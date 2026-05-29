Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B1D421F1E
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079758; cv=none; b=pfR1xAf+JB0lnClL27ylwrsFE5TNcPsPfbOpYmMECHKoSVENPEE674PsItqm2HtkWCn3w4/btACVlw3UuThfs3bYxA726ieg9cr/vdTcZ+SAxQcLYtDG28/AEevZ2qx2brapyKIW3vmi90iPNdnngf6LezNcDgh9lhEtHVMti/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079758; c=relaxed/simple;
	bh=1pUboGVTGTbGNTWIr7911s/ojq1kxLKwC3wwVQmcasg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=exBuUEigB9GG9YvIs1RjxD05WUFxp+lZ+cn4fvLA9wvJhdkRuQxmK5Gzb+U4obVAKfS5VCnfEvwkHT14sPIrhbOj+qCOr5K3GwAcWN6CFll0VMDL70lGxxyWjt9cx9vzKceMrjgED6LHuabzAj+3GJXgXJESfTo4jhLvkFo6Ldg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AwzVXucN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=W5k0oFu8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AwzVXucN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="W5k0oFu8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ntARZ+6qGDkNDZzF/QBmpzXqfdRaWpB6bSEFpJx2YbI=;
	b=AwzVXucNitMpZAGkcGsMFJzNINg375aysP2aaSRtQwnVvyYqiooHd6/HB0A/jokJfgVZdq
	2mSvwGZzDMFK/Us5b8/ZEl5yEFNDDuwNkf4noBdM3sNACyetPCkGaBTftLaALWRXP+rzGH
	SquvszYxczRZ7iWV8vgrrs4HdkWzTC8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-7VItQEdPMhuasbD2CRVyCw-1; Fri, 29 May 2026 14:35:52 -0400
X-MC-Unique: 7VItQEdPMhuasbD2CRVyCw-1
X-Mimecast-MFC-AGG-ID: 7VItQEdPMhuasbD2CRVyCw_1780079751
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4903dcb32f8so71070205e9.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079751; x=1780684551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ntARZ+6qGDkNDZzF/QBmpzXqfdRaWpB6bSEFpJx2YbI=;
        b=W5k0oFu8g/WGVyCg1GkIKhBVS9lJXA/fCWlGuKTwO/xfrF4VTwt9xeU79s9RKV4M8W
         +y4AiZ3easMJDBWGnx4d3KwOwTjjCMhxr0rs+9b2JWOgzaeFvjbZ+mPO91sYp3r2s18I
         QGQTzWa+lS5OhIw0wYHV69MLMSLmt/ORhX34qTjFx2Xwx/DLJpJUOvcISeGx3XjOo2BO
         ZscL3sY1C7HeWr+ZdNwwyYwwVhrYLqUItFOq5tlVws7SukuYyY2c2JkaFVpb3UMWNVqI
         YUDkkIXnFzH5A0Y9znUm8OfJlCnDo7MMspGUnKh/hF7JfpZyKaUigEmhkVN/HBX5qhAe
         oCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079751; x=1780684551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntARZ+6qGDkNDZzF/QBmpzXqfdRaWpB6bSEFpJx2YbI=;
        b=n0yKWJ/CtkfZxF8cFxMmGU+DrcdxsxhLUnQkL2+YqWtniXqhvEkApnCxigd9KAz7GO
         6CWjTNmo2sK9hKTY34GnDggNmfLr8/4hJ8aP/aso/1wpE5736q++HgFiobHNgBk2Vxkb
         PvmCBhiSxyPMITlUTp6+mqWg7lg67xLdXUTKEJoBBA+3uDy7TgQA4TZHJLdHXyyCz96E
         VggqiAWZrNESrLrfuEz01xMluUyjFYQ9f9EgYPXNezgOdwO2DDyWIyYEPYRlsOpFcKhd
         kjKIO0XH6WRjFtsQv4Xsc6gGJs7Mt7xgm8tXT2XtK23FATsOePxbKS2sD5NltLTUMOGF
         2a8A==
X-Forwarded-Encrypted: i=1; AFNElJ+wGfD5hHStpfWVUpzlMSfisfon5nsM5//nBpdB2Gj8TisLEcSDEWvVEjy3dH93IIg+dgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Qydo7iZXxWU6tUNJQKAf40DJT6f0IIWa4IA99skjnRwXGdxS
	YdIaEG0e60vvki0lUEq1U74vq/Kng2nvUMnx+hDCFerXZ1qIUnYEfvG0iR1rXnxgN2YjtDuyzgn
	nJ5Ev0P03JP5MJw8pMvOnHz1yG1b02LYlZnDniZ9aPmsocBjXBUal8A==
X-Gm-Gg: Acq92OGOqSHU/3YmGIfOKw9T2Z3xeukxLaxiADJFPTuY9H0fw9q9QqH0YusCYN4DaZe
	2aDPMDrenbHM1Td6CKqzLlRbGnWSnJ9RblMWGdPrp5OI3drAXUA5bxCNwOmpzEHBk62wJueNwEI
	g0HYqaqeoXyHnMqC5G7mTXDz712AbSXtvAquvFjvHPYvdclN7LVkFSgW0YLk90S0CMCrr/VedQG
	/HQZgbP3UtLek8f8ZP0iAsvZ/bXOrw1LP1OeL0B9koyY8sFa78SUOGegC7vv9kuu9/K1cLFrpdl
	PXKP8w+Zr/JVUzsiysx8ynsvEaPllYvd4qDUHmlRnVzezV3Q1EMQ70dPnL3wRzXOraRMyWmIe7j
	Apm3B1CoyTQ7v/hxrz3UTkniuZy/IsP2mL2hC3s9cXVKhk17sIgsZCP2z4PEOnBz+dnObSuBLb4
	RJDfcq4jILqSdE6lsKIzkriB5PtGR4O5wQ+Ry0jA==
X-Received: by 2002:a05:600c:1988:b0:490:845e:3a6 with SMTP id 5b1f17b1804b1-490a295013bmr14050195e9.25.1780079751444;
        Fri, 29 May 2026 11:35:51 -0700 (PDT)
X-Received: by 2002:a05:600c:1988:b0:490:845e:3a6 with SMTP id 5b1f17b1804b1-490a295013bmr14049925e9.25.1780079751152;
        Fri, 29 May 2026 11:35:51 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d6f3027sm51925345e9.14.2026.05.29.11.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:35:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>
Subject: [PATCH 00/24] KVM: x86: fix various GHCB issues
Date: Fri, 29 May 2026 20:35:25 +0200
Message-ID: <20260529183549.1104619-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PSC code has a variety of bugs, several of which have to do with
not following the spec.  It took a while to disentagle and root cause
everything (the GHCB ain't exactly the easiest spec to decipher), but
here it is.  The first 10 patches have just been sent to Linus.

For the rest we decided to handle it on-list for 7.2, but it is possible
that a clever guest could abuse the bugs to cause the host to leak a
pile of pages (limited by how fast the VM can get recreated).

This can also be found in a sev-for-7.2 branch of kvm.git

Thanks,

Paolo, Sean, Mike, Tom

Michael Roth (1):
  KVM: SEV: Require in-GHCB scratch area if GHCB v2+ is in use

Sean Christopherson (23):
  KVM: SEV: Ignore MMIO requests of length '0'
  KVM: SEV: Reject MMIO requests larger than 8 bytes with GHCB v2+
  KVM: SEV: Ignore Port I/O requests of length '0'
  KVM: SEV: Use the size of the PSC header as the minimum size for PSC
    requests
  KVM: SEV: Compute the correct max length of the in-GHCB scratch area
  KVM: SEV: WARN if KVM attempts to setup scratch area with min_len==0
  KVM: SEV: Don't explicitly pass PSC buffer to snp_begin_psc()
  KVM: SEV: Check PSC request indices against the actual size of the
    buffer
  KVM: SEV: Use READ_ONCE() when reading entries/indices from PSC buffer
  KVM: SEV: Make it more obvious when KVM is writing back the current
    PSC index
  KVM: SEV: Add an anonymous "psc" struct to track current PSC metadata
  KVM: SEV: Read start/end indices of PSC requests exactly once per
    #VMGEXIT
  KVM: Don't WARN if memory is dirtied without a vCPU when the VM is
    dying
  KVM: SEV: Move sev_free_vcpu() down below sev_es_unmap_ghcb()
  KVM: SEV: Decouple the need to sync the GHCB SA from the need to free
    the SA
  KVM: SEV: Unmap and unpin the GHCB as needed on vCPU free
  KVM: SEV: Don't terminate SNP VMs on #VMGEXIT without a registered
    GHCB
  KVM: SEV: Move GHCB "usage" check out of sev_es_validate_vmgexit()
  KVM: SEV: Return INVALID_EVENT for SNP-only #VMGEXIT from non-SNP
    guest
  KVM: SEV: Return INVALID_INPUT, not MISSING_INPUT, for bad
    GUEST_REQUEST input(s)
  KVM: SEV: Handle unknown #VMGEXIT reasons in sev_handle_vmgexit()
  KVM: SEV: Turn sev_es_validate_vmgexit() into a dedicated predicate
  KVM: SEV: Remove sometimes-used function-scoped "ret" from #VMGEXIT
    handler

 arch/x86/kvm/svm/sev.c | 554 ++++++++++++++++++++++-------------------
 arch/x86/kvm/svm/svm.h |   9 +-
 virt/kvm/kvm_main.c    |   3 +-
 3 files changed, 302 insertions(+), 264 deletions(-)

-- 
2.54.0

