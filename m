Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7BD2EB84E
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 05:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786424453; cv=none; b=L8avUPxT3c6x0cNMUEQvtbIqa10luKN9uUqURqpd4zIyKv2ygWIp//GFIODND9kkZvzYIqfS03PUpRAkbFjyo4X8M2R5emATIFWjzo08jDqnimGWEGsa7tGAfLNAV8qcAQcPMtPQCI5Jv5sL7tjdJCNtx5TksN1YuCcTsOmfroE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786424453; c=relaxed/simple;
	bh=o6x4ZrBFFyJQtHw+/MAjr/5xinzQ/QrvRCDFwRw7OyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKBYXoSRNVcIfnySPZMUFCWKg5ZMUAwle7wHOr+5Gup/xrnu42U9yuA7nNHal/tcM6wOOwQAQtunUj4jokvO0SqvYXTTzbqfiKhyIzmSScbdkQ9cr5FJ7AhQLHNXmJ3CnfmtlNpt9s4TqM82mwZwu1VQ7HILdkg1GHUttM3FoYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcTfIPB9; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcTfIPB9"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cc891373e0so31923885ad.2
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 22:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786424452; x=1787029252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y5Yp2+G0Crvx2BGRAs6e0B1TwVgIjZjOOiINjptRlyQ=;
        b=YcTfIPB9ph5gDPCus/zZNwdB46op3PQqqkySYdeRWfrfPtO51j++jP1GkG0gh0SfWw
         BT8VcPgYEZo0/AzKuqq1KMWi8s/o8XxFMYZ7X/k/QMntKSud65IizKtIt51JSrtlXF6T
         rukx7QrUjESjCKacQwVKXE/7pEjunEV/7ilobvyFy0fH95Iu2KDuVkgjPjZ8StKgUZhL
         +0Hxi9N7Bzu40wkA70mioHe37tAiIbtkPmUSC2I9+h+Dr7liN70dJYP8BxSTtVXrfAJ7
         lsRs3pzOjXVojkqvNPKsjrQvlTecV4XayIoRFpZfJkyea1ticqiP9d5qtNjee7VTu7gE
         aS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786424452; x=1787029252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y5Yp2+G0Crvx2BGRAs6e0B1TwVgIjZjOOiINjptRlyQ=;
        b=C4LcQ2x1KsvMFzOA3MgRuJUHs0AxL3bLgJhjKvwFvo41H2EB2HeERu6cBhNbWBGdES
         naEoAPN1SowbGpwDVn0FZVNQK/mOO+854fK0D7dydJqBZ28f8zPm1QtS4FIdF2QPRkYM
         zdRLEperlJO6lCu6/gZhyBALN1mlVvs4wmhVIwPsOxVzqFkGY6T40mUHhmovzvitkcDa
         AVNX9Yyo7RJDMdrP4GFruYGvkt7UyCVe9WJnpLaD6wBmQc9z3PeWN9gk45SyifK4J8Vl
         RDoyyVWH5yGycqMaDwPiVefjesebkAQgDz2ujxgCH+tGHC4UqN8AGbo8SrWBVjj8Cibp
         3oHQ==
X-Forwarded-Encrypted: i=1; AHgh+RoOT5zcg3nTLH1K29qdjzVMrSrD8n9YAoRl4YCbZOXcvEtuAG/t2r+MoLMukbfiVFexusU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyesgrC2hFJI6sDNgkuyEY6pmtILKpMAXsh90EmxeTa0/xqvR5m
	aCnSOlj6Ad50fh9Mjl3Pow6xuMgE6B6FDXkRwR1pkQgIkjOo4xP6QuA0q/HpDg==
X-Gm-Gg: AR+sD12QWxPw6i2jr66XFaLn0XJTyAfhoy6BDQK6i1nuBqrh9CYTMtRWqheVUfFA4tH
	1RWlsFcfslLKuNAegLDNnT5FX+HoACTPkY8EN43QB9+Yp2K9edYDGH/MBX92lqaxmoimKsauCPJ
	prvaQFyhxdx8QFEArM3O0J3ZQg3xNOw1PNEGBSAW/r3n8MfALoMcWEsM+oF9NNqsUmjKvMgumxR
	P2gjWtIhiaABpKuY1aPSm/Q+EbhSZD+JkYd+dfjOiLkHuDBj0DMSlQ/dr43ROF922mAthpcdW3t
	F9iYKPbXfAgd8Og3EWSZI4rUvVLV6/xcsZLB+gvxQDKRWKIX//dhr8zLjmtGIxfllim4kKHXSXF
	1eFUF8KsY/dooWT9F9M1UAfJnU+n3/hWMYEcayvphBQuk2x2hhinL88eOggOUxHtb9ddtH6S9is
	Iw601PE8TnR4mIuivvg/SKwLH/QlSxU+lqKxpfrEM2yxfXBJO12CwJB6G7T9V6pYUYIa4bMtdCF
	g==
X-Received: by 2002:a17:903:3c63:b0:2ca:6c8:abde with SMTP id d9443c01a7336-2d3179240a8mr10712955ad.18.1786424451576;
        Mon, 10 Aug 2026 22:00:51 -0700 (PDT)
Received: from 10-86-27-207.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31c619d0209sm587312eec.5.2026.08.10.22.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 22:00:50 -0700 (PDT)
From: Gokul K <gokul02k@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] KVM: selftests: Free the VM when NX hugepage disabling is denied
Date: Tue, 11 Aug 2026 10:30:29 +0530
Message-ID: <20260811050029.530698-3-gokul02k@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811050029.530698-1-gokul02k@gmail.com>
References: <20260811050029.530698-1-gokul02k@gmail.com>
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

Jump to the kvm_vm_free() at the end of the function instead, matching
the pattern used for the SEV smoke test in the previous patch.

Fixes: b774da3f2e57 ("KVM: selftests: Test disabling NX hugepages on a VM")
Signed-off-by: Gokul K <gokul02k@gmail.com>
---
 tools/testing/selftests/kvm/x86/nx_huge_pages_test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/nx_huge_pages_test.c b/tools/testing/selftests/kvm/x86/nx_huge_pages_test.c
index 70950067b989..e3b20033a884 100644
--- a/tools/testing/selftests/kvm/x86/nx_huge_pages_test.c
+++ b/tools/testing/selftests/kvm/x86/nx_huge_pages_test.c
@@ -120,7 +120,7 @@ void run_test(int reclaim_period_ms, bool disable_nx_huge_pages,
 		} else {
 			TEST_ASSERT(r == -1 && errno == EPERM,
 				    "This process should not have permission to disable NX huge pages");
-			return;
+			goto done;
 		}
 	}
 
@@ -213,6 +213,7 @@ void run_test(int reclaim_period_ms, bool disable_nx_huge_pages,
 	check_2m_page_count(vm, disable_nx_huge_pages ? 3 : 2);
 	check_split_count(vm, 0);
 
+done:
 	kvm_vm_free(vm);
 }
 
-- 
2.54.0


