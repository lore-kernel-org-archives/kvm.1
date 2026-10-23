Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792715830;
	b=hqVMZQU8j3UGDi89Zso1gfxiF/fLLJ04EQWLH6K3B+7wCSnitlPaIUN3Y6i6KwZ6Ee4s
	 sL+PQ27bOT6TiWFqpHPDLLSkspX+gmIGZ5AwylWylTR3wscozzRYckXGwNjh+Nph5SG/5
	 zpVEeFo9/puS4pHAk0qEkrwcx2sprN9DwNBqPob6xRL50c+aMvZ6L3vyYkqRj4mbi/kuT
	 am6MFESHohJ1Vm25TExc+Cz5Eg8MaSr3fmeJ6HyyBlYyTYowDh2w/KEAyiUSFpL9XyhTJ
	 sS2tTFhNwVb2Igqoe+oF3gzJxx0NUrUcgknAkGlQSbLHrpKJgGsMw+2ylZ7pexQqgkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792715830;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=VVFibIdLtPqndtnVc2dqUS7yKr9vOJdSVF4rU6lBVbo=;
	b=HbEDlhusRmgNAQMiJ/RbvV6wDFVcK66tMib+DrBC3hBp26PpctedJiQMV28r8/9qtaAB
	 hnxmKVgkWeoMzhfXZK+cJpuBRGiJk3EjJ+oAZWgk/QLNF4xTR73R0upEVKMyktCcFSv75
	 8x8CeqHbO0NUgzhLjZGftU4jqxmxCgsGZcY9ZoJxYSxHQLYVlaecA4wIOVwe7qCxcDXee
	 KJrNye4R04Fv4hPAKV7XTBnPDLrZ/HmUyj8vtPOQziQj9Lq2tpBE6ArCBXlAt8r7VXW9o
	 rUtXDz4l6La3m3IyNhcqZE+8MWn0d8C78GdMtb2qFcCEBm27b1tEkgqjRY1hX1eBcbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rLxpBxVc;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A934606A319
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 00:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A934606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rLxpBxVc
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d577so264800a91.1
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 17:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792715830; x=1793320630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VVFibIdLtPqndtnVc2dqUS7yKr9vOJdSVF4rU6lBVbo=;
        b=rLxpBxVcixkK+51+Z4/1+3dhIWLpp9PBBGBj00fP7WbiAAe2ETfX2l0Bz/8aeFeEx/
         S3Vrq4hMXRhjJVBtuRM8bIoZ/M3JNwa3WO/pNbe11Wr6a12npnwvjoD2nP9vc/Hqdeot
         TVfiGIizeNDZ4DP2rQco9xxscDrbIr9vvBSmAKod9msHExoguY0a7TlKjgl+GWJqOJOg
         dCbeyp6p8m9Tm9HWmSEkA9I6C+ilj0rTh2MTe2wLz2o9QFYGFKrniAPxzOizgE55g/mg
         O3BLAceoecepk4jjEhRqz2t3Bu2PvAHCb9HwCG8ZJV0bkfbefe5shztJi6VygUxgFQuT
         U1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792715830; x=1793320630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VVFibIdLtPqndtnVc2dqUS7yKr9vOJdSVF4rU6lBVbo=;
        b=dROBhPDKlC0ZU8WZ2czKXLi78eq+BJG/du1yLowr/xPED0bfPA3+sroQHQ2uUmYgJr
         IKaQyTNjr3lmFIbGNPrOdmW6uJoRlW9riJCY3TEqQh6MuqVGzKY7zoveA6bzytZ9+AbZ
         k4f1EtIBI0vl8hIk0iJE7wBzVRQ9MYjjljN05P0FmLg0huulbk8PTmjOZ/WP0qipUrJf
         rfFWk6O1sZ5LmBiMY6YJidm0ilA9kd3XprVvgAdcUy7ixtaY0qarBwzsyBf6E8b/Fadj
         +jGt35Q/Me7bZojgIsqXuP3OLodw4ikcaPNT6wzWirlN0LDhYDipuuqck67R44yAmIZ9
         SgJA==
X-Gm-Message-State: AFq9FYLWSf3urnP0F3odsW9CnpCg7XuDfgTjCBobBQJo3rLWnwDd8CYE
	cj7GOrvcXw/cAcxbTUPkr1ushwjJeqexzC8u+nHyPbXjJkRqoUBpDHh+MDwZaQ==
X-Gm-Gg: AYBFou2/KD6wO3DKl3+NVVVhBVpQWVpv82X5lEiNVYgdCtibL97TO83aU6seQ0FegHf
	9vFlKvrOu0liqbaR8ZyNdH7xQCFOP+BmB2B2qXxVp6YR2hggJTjyG97XsB5fgPVZSDn+VRRtYaL
	GxjJTZUBPWQ/Jbe63BZebuu75S4M+i2btDg5w8v3j1cCV147dFGpeScliKQU2l8bZrsjmrFqAiA
	thNFIhnMXIOPHHunvbrd0ojvCrDomDbGUqCmuXyGvASV/eWHTjFUBrUuJixQ2HaJpdEhYh3jR7i
	90MH/IxPDk80YMVmMTFoNOHEKfQzGBSz4jrAwiug6K6/+4HC8/auqAGlxBqWyRZivuTiLXEHiKi
	I9Viy1PMR6OP1fNHksrZ2USeIXAzgIwmHEtt2ayhoWEa5ESZ0WcLkVmWi7hCR3n8qH5Rc2m7/km
	Z81anvrQNJxTyLo+yj71NgXClGo9Jztz2SIXswOKKxd6JkHVqlc9pqnmPgnKcHD+iIcTp3uatgX
	pxwegDokXezJrUxcyo1fz6K0V4UHW5dsa8LZ4u9d8v9W+yP6s0pbD2jo04U4/ntUhStlpWX0Ucu
	OuGJpBx2Z21ZT9cObzXHlo/3cxb74YCVAaymNfAvIvXjdUiKEaBTQH1d4g+7Kyqp3kU=
X-Received: by 2002:a17:90b:4b84:b0:3ab:884b:65b4 with SMTP id 98e67ed59e1d1-3adce154993mr460193a91.59.1792715829881;
        Thu, 22 Oct 2026 17:37:09 -0700 (PDT)
Received: from monk.wireless.sfu.ca (border-p1.nat.sfu.ca. [192.75.244.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adcb0a28f3sm964360a91.3.2026.10.22.17.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 17:37:09 -0700 (PDT)
From: ma.mandourr@gmail.com
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ma.mandourr@gmail.com
Subject: [PATCH v2 0/3] KVM: nVMX: Don't clobber VM-Entry instruction length on soft INTn exits
Date: Thu, 22 Oct 2026 17:37:00 -0700
Message-ID: <20261023003703.450577-1-ma.mandourr@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mahmoud Abumandour <ma.mandourr@gmail.com>

KVM writes the length of a soft INTn that L2 was vectoring at the time of a
nested VM-Exit into vmcs12's VM-Entrty instruction length instead of the VM-Exit
instruction length.

Patch 1 did not exist in v1, but Sashiko pointed out that prepare_vmcs12()
overwrites the VM-exit instruction length that vmcs12_save_pending_event() saves
for soft events.

The selftest patch was written with the help of an LLM (Claude Opus 5.5).

v2:
 - New Patch 1
 - Same Patch 2 from v1 (with commit message changes)
 - Patch 3 now extends nested_exceptions_test instead of adding a new test
   (suggested by Sashiko).

v1: https://lore.kernel.org/all/20261021042603.608292-1-ma.mandourr@gmail.com

Mahmoud Abumandour (3):
  KVM: nVMX: Fill VM-Exit instruction length before saving pending event
  KVM: nVMX: Don't clobber VM-Entry instruction length when saving soft
    INTn
  KVM: selftests: Verify nested VM-Exits while vectoring INT3 and INTn

 arch/x86/kvm/vmx/nested.c                     |  6 ++-
 .../kvm/x86/nested_exceptions_test.c          | 39 +++++++++++++++++++
 2 files changed, 43 insertions(+), 2 deletions(-)

-- 
2.43.0

