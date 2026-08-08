Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4813A7595
	for <kvm@vger.kernel.org>; Sat,  8 Aug 2026 08:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786176695; cv=none; b=Lvd9+lkmyTKNepceLYM3QuMgJjUcZbUfkGnXp3DRBhjzsix8JVtrz1CSb3tqufFuX08V01wZoO6oLkN+VG2a72NNSluwIzw2K/P94UdWjVlckMRElNT7KeA0wLv0+f/TiliSVjD2B7Kr+AaLEfKo8LfxBwqJrvTjcGuTsXpO7a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786176695; c=relaxed/simple;
	bh=MGb5suHwKenoO8+Yoit0TZ1mClXS7TepI3s00xmuOag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GC3X6mmwvEB+uq53ekre8Wrv6il0x92pZfOVhTNRgCTeb7ayK1MEdxMhb+xJC1rxeJ5xdY1Qp9kkBsMYMguG8ggBmf5raWp+xUbK6GznfbqKgyIPlXM+ZkwRMaw3BbOaxrwg0CJ/cixP20utjcroK5S2eCZTd74OBbEvlIBZEdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZITh+bIa; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZITh+bIa"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so172619a91.0
        for <kvm@vger.kernel.org>; Sat, 08 Aug 2026 01:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786176692; x=1786781492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F9dVgwGHiDFCuZ0x2p4Z0K2PT+mB10F3qNo0u+NxB+U=;
        b=ZITh+bIajm7bYWL/DiNPGuZ6oWti+Aeoagi7E6GE4vCcaGjfD4jZ7xT1ET7vVGhcsq
         msHlaZ1nycChIHwiMUX3OCIDB/abgpAhcLgwX/cXxptfhsQ6tae5aWSuGRaaBqqfGy/i
         Y2i/48oCIko3JSzYpCZ2yGoA2XtwzPcMpouu7RFwpX+Z+UTjJPet2ioIIXsdCcQ5NTOl
         eMKM1ivHEcWZ57qSJzU1Ex5WOtJKS11rTOmDYaWFdMxD0KZXOIccmafIYGdiSo53Zaji
         A4LKpwS3R67akJ6EfQQHVMsrD5Snx0w8JPXYEAAA/QaQfV4UrcUtAzFGnknxcfztQ2a4
         jwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786176692; x=1786781492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F9dVgwGHiDFCuZ0x2p4Z0K2PT+mB10F3qNo0u+NxB+U=;
        b=PWLhiKCEGJWc9xhP9xgrKIgFiGY5xXSeDLYguHe2ZRf05NPSwioajRTNYBD5Dh7Cvs
         dtGnygg8GRf6racKSldx1VxwFJNa7XTul4ySPe5Ml/OZrvnnqramBhU9/7zbenfDXfTF
         ivviNRvkZaFAsucLexBTG26g5+MV8aSjzQOJQ8kebnBJIM8k7yvGxpIcuoi22DMZ9AeP
         Ex5zoxoiOSuxisNpil8gsQOw2hz+ao8fMAEFN4/99LEb3pj5vIySaE4TwGDvUzRsEjVr
         s/oR5soVzIjb2rsTMHKuCG1Vj1w8trVYO8gyQ7Bvow8Pc73o+0Xc4BBQz0us14kQdg67
         tSHA==
X-Forwarded-Encrypted: i=1; AHgh+RpVduSxQZfEjwdzZ4DSFMzYG7duGmvJd04D3eLPBcmOOpk3pBNHxw+U1UjZlZjn8t9aM/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmHzqHtbbVwVZNPiktYVRack9ZXaV+bH6tCsXIUid/1ldyOKFX
	lNUQKxIXunZ/CaQDooq8YdrG9k1vDJPwzy38+o/1bXjA0OaXtiVGsHxW
X-Gm-Gg: AR+sD11XfQcxQQ8XFVJLPXSyowO8C9LJePAGqcjglfQFM72Z6wuebsi2SOnA+MG3zbj
	goayk+2CpiS/kjYvMshNWPv8bMt6r4Xa+2YDeV/vq6Ln1eoHFLunP+NUCkFoaHay5t2t5Lyxm/M
	YvBAiJpxWAEClmLMFh6D8Lv3Pv3u91XCZWzFLY6HVxZ8BWBQ/wjJhN564UJVt3LC7yiTSdBfoZG
	SywEXscFhWc9agkkEtl5cOXUQAtAcuPx14jY7HA4WR42wOhIcx7SzsKZwwUwzCq7rWRsHreGdJ/
	kRkvFWxZc8K44mud59/i4/xRZb9wmHyNZGlGFy5yjf5iGbsxgyaxOD9jUjKjmTjzSanyREbk40o
	tI8Od9G+X9eq8azzCNCyTU11PYzmXKRIptcHdy9naj86O0iVOdGaYSASB9U3UnWspbLqvarRkux
	O4fWisr6+EAGQcKSEA7zGXgOHEWB5piSyPjLln+TNnHuiL4N360P+ZG3dqfInKf/1It0jFJEwf+
	SsGn3cZTvMi
X-Received: by 2002:a17:90b:258f:b0:38e:c232:9d3f with SMTP id 98e67ed59e1d1-39282247ee9mr6250045a91.5.1786176692047;
        Sat, 08 Aug 2026 01:11:32 -0700 (PDT)
Received: from 10-86-27-207.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141019b41d9sm13660310c88.5.2026.08.08.01.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 01:11:31 -0700 (PDT)
From: Gokul K <gokul02k@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] KVM: selftests: Free the VM when NX hugepage disabling is denied
Date: Sat,  8 Aug 2026 13:40:50 +0530
Message-ID: <20260808081050.408657-3-gokul02k@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260808081050.408657-1-gokul02k@gmail.com>
References: <20260808081050.408657-1-gokul02k@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

run_test() returns as soon as it has confirmed that disabling NX huge
pages fails with -EPERM, without freeing the VM created a few lines
earlier.

This is not an obscure path.  nx_huge_pages_test.sh runs the test a
second time without CAP_SYS_BOOT for any non-root user, and main() calls
run_test() with disable_nx_huge_pages=true on its second invocation, so
an ordinary run of the wrapper script always takes it.

Free the VM before returning.

Fixes: b774da3f2e57 ("KVM: selftests: Test disabling NX hugepages on a VM")
Signed-off-by: Gokul K <gokul02k@gmail.com>
---
 tools/testing/selftests/kvm/x86/nx_huge_pages_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/x86/nx_huge_pages_test.c b/tools/testing/selftests/kvm/x86/nx_huge_pages_test.c
index 70950067b989..49b70c05daec 100644
--- a/tools/testing/selftests/kvm/x86/nx_huge_pages_test.c
+++ b/tools/testing/selftests/kvm/x86/nx_huge_pages_test.c
@@ -120,6 +120,7 @@ void run_test(int reclaim_period_ms, bool disable_nx_huge_pages,
 		} else {
 			TEST_ASSERT(r == -1 && errno == EPERM,
 				    "This process should not have permission to disable NX huge pages");
+			kvm_vm_free(vm);
 			return;
 		}
 	}
-- 
2.54.0


