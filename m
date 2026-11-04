Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793753617;
	b=ltPy34baQzhJMLB/x2O+9Fy+H+5daV9XKQqM0MxJnoBJnhf1A5LIlC8qcFZRPw/2Z4eT
	 7fM3l7rz7xGXrx43MLDRKnbeHnvjtuF95JNV4Lg28Ye3qlY2FjXg1nFeB8LSl9iXlT3lR
	 krzXJ33RSf45UprygwBuHgM0HK9+xnk3NxVaaqYgqEffsmn2i8xVdsq2H4VW2X2RzLqan
	 s8O5N8SZfDjfupLJ8wKbMMlBqliSI2J41UNPAoltpVh4v15YDkZIJ7MXxEfAcR6W6qEz2
	 kbFmBOAsPK470Cx9/fK92Vojf5CTtHqciQS7Wi+kqQnrJxOVWAy+4nEgdkOyjjDJxnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793753617;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UZsXZ02nbL2hg22ERdNFzFlplemnVF9z+ZbjZ8pAabY=;
	b=CsAxZPmvMvbCTNmBFTvn8344R9Afol5bUpKURHY8Cc7P1DSiaiWB03VE5MN0rpub7DK8
	 8tXKG0QwIfyJm7w7wV4dBKNQmlvsA2kguizPwzpxEgpTpJCaxh6nBp2WPNxdv302LIapR
	 XHnXjouI86ubryKW/6QlUsZX3HCTJgIWl1JYE/HSaz6m8174CoaWjyPtAN5N3V5Uo4XCN
	 3sekufIJpBI8IC0Q6EK+vUC92KDd7bDoGRrMDYobHd4yDTreC48JAwjOXV8e+ug7fJeia
	 n9a31ZSuvArBZ/kEuNrckWX1+MKPqV26UEZGWbSxsZSy1O5+1hNN8IwVGNQMN7CbJPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TjcOfRTY;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E261C606D823
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 00:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E261C606D823
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TjcOfRTY
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso1067265e9.1
        for <kvm@vger.kernel.org>; Tue, 03 Nov 2026 16:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793753615; x=1794358415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UZsXZ02nbL2hg22ERdNFzFlplemnVF9z+ZbjZ8pAabY=;
        b=TjcOfRTYOnaF+fOvHhHOGPjpsJdmuosoa2/QZ1zCe1qZlPGuUGnXeIRnPMpcbIphfY
         ymW6e/Uh77Si8NPNFZXMdyguMNluO5K2eb9odmZrG/ELTvfloIscxI58JAohA6+i07Fu
         trbTj3c1wQDLPg8cPU+WBNOIoLfSAtCBmlQwEQ1sKBu6lafcmxO+R8Hz7+YTmt/r5Tqs
         slmyDiN/gwg8Q4bsfIZhCzKQ/D5vSJNghPa8keSe64dFYmtITRs8dKKfRGwtJlBoZHQa
         a6mF2cmserdmD7MU2tpknr6m0WdQImD0F2XtACoqf9JXSTAtZfl42CbCh5zOyLo9fUVV
         99gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793753615; x=1794358415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UZsXZ02nbL2hg22ERdNFzFlplemnVF9z+ZbjZ8pAabY=;
        b=QOLfeeJ6Fp9T1L0S3sRgcHoMRTlrXq+1/ppwJ74na1g4Cr1F0MWWRKuRFL8OkSmipK
         7C4Thu872D7n58+IVa7bo0/O9YVfzl/Fzmgc806g4DghdNHlPZwhdE9zmk/o/8HB3z4U
         E7ZS0wwCyBkHW/m4hnEBHLq6AjZnz8G9jGQCz86vApID4tnVo7bh5VESIjX1qrGsuGc4
         C1stUjH/GIAYTVLhv8YGRNqns4+zu5skrkuOtNX5w/87bAdPispSKE7LQwVo6XJFgOD4
         WL9MISTdwl0s3OYTiXBnGc+Ad2jYeLY48BM2VlEw4aylBUHwMHmS8pTmzwoD03Lacywg
         4ugA==
X-Forwarded-Encrypted: i=1; AKwUvBx6D7agE5sFcCER0QsJMmxjaT523ivSx6S74fULoPYsnJdVNkQJeTe8rq8CI5Yzz9Gtrrw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+8Q9EjNfxSckNQ1gP+YEdylHeVThVZPOxtuRjSk54++FFUOo3Y
	mcbJQyOTwYMwsJB4omce2y3v8pzHynjSfh1U6yMEak2rGf2T0T54Yh4G
X-Gm-Gg: AYBFou3BxAmMtA8KiqCk7bcFV9MTC2aMtx1qUuENUysO9pBhSIzlpW7kophOYcg5wSQ
	KhB8gS1ffNqisfOGKlsAWSKZ/g6PfjlY6gSBA12oK2PX85aRKmVAMsiv4IWcpcoEDzwL+Rce9eA
	+OqLw5CnujNEUv9ab+L7KR/qJoCzhXXRzARwXtzTiEFdkaIOPTkMOyKDufsoopPd5ZwgR+fH5BV
	kxkw09t6aFt/gLaDgThO+MKT6PFXx8Z2DPEHi5EANPzrXMDJd7Aghv2WhiDgbUJlYOqEvMLcwdN
	LNUgBQsUKZheETVQSCG1qjn/yCq5NKsRYIaCMGPJUqCJbv3Rz9I3RfyutldwlysO+TcYJJi72Uc
	h6YgMke2o4qi0HqbHxc6fgakq6dtvhuCkhQlud16MXZUoMhQRI4Rv3UOx5CAy9kcAvX8DuaqiQT
	p/F0rq3tLgcTuEr/zvkeoC+ymMw18blOXMjuctEN+5J+rrSJtJynr1MpTEa+0Mwj8T+T3MRwdI7
	Y4oi6GgzjQyhG4iXnI9tupb2vBKSWnYABj9apk9ul+zTwubziIeIY/HSVz4k9mJeVWsfvm/qnfD
	+mfrJjZ+NYNtxcPit8JgsHcbwLCeUeocGQLwLPn6BfU0C/NTB8Fr1BLyKwczAc9y9l7lQVDTd4l
	6v37VmJErvj14rMcIrvnJypEvrg2kkWw0jjsWqZdua5d9LEE75g8G5/SeoeiSo+GTHQ==
X-Received: by 2002:a05:600c:3f0a:b0:4a1:d8fc:8165 with SMTP id 5b1f17b1804b1-4b3c3545341mr36673425e9.20.1793753615281;
        Tue, 03 Nov 2026 16:53:35 -0800 (PST)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43c17ed95sm11899275e9.4.2026.11.03.16.53.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2026 16:53:34 -0800 (PST)
From: Fred Griffoul <griffoul@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Mushahid Hussain <hmushi@amazon.co.uk>,
	James Houghton <jthoughton@google.com>,
	nh-open-source@amazon.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/5] KVM: selftests: Declare __tdp_map() in the x86 processor header
Date: Wed,  4 Nov 2026 00:53:30 +0000
Message-ID: <20261104005331.50600-5-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261104005331.50600-1-griffoul@gmail.com>
References: <20261104005331.50600-1-griffoul@gmail.com>
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

From: Fred Griffoul <fgriffo@amazon.co.uk>

Tests can only map L2 memory with 4 KiB or 1 GiB pages in the TDP page
tables L1 uses for L2, because only tdp_map() and tdp_identity_map_1g()
are declared. Declare __tdp_map(), which takes the page size, so that
tests can also use 2 MiB pages.

Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 tools/testing/selftests/kvm/include/x86/processor.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 5898a277a2e0..66293e448ab2 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -1613,6 +1613,7 @@ void virt_map_level(struct kvm_vm *vm, gva_t gva, gpa_t gpa,
 
 void vm_enable_tdp(struct kvm_vm *vm);
 bool kvm_cpu_has_tdp(void);
+void __tdp_map(struct kvm_vm *vm, gpa_t l2_gpa, gpa_t gpa, u64 size, int level);
 void tdp_map(struct kvm_vm *vm, gpa_t l2_gpa, gpa_t gpa, u64 size);
 void tdp_identity_map_default_memslots(struct kvm_vm *vm);
 void tdp_identity_map_1g(struct kvm_vm *vm,  u64 addr, u64 size);
-- 
2.47.3

