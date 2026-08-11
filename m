Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD4D30CD95
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 05:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786424447; cv=none; b=C2LVdgzqPCZKGZb2NJa2c7fa6HcPk9g+L+mzraU2UdJOfSDCyBWRogMWjR/g32KuMAJlmdxKUNy2M6D3JVE+Znsu0xturm+rl5iU4zErk0v0+GtmlpF31fYcpFdnudHpp8McyaPSRN76es3HI58L3UtIDvoQOSQplUNTHy//ihc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786424447; c=relaxed/simple;
	bh=kz5eF8EgHJZV4kT1Yjijkfp28Af36RtKI66Pm5tq4pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BNHloqzPOPqdXEakkk2RPaLOnCSfhfLWIKE4xMm9EUcghUsaMNC94RTevMKuUMx2uhBQcr/4kYsT1fxMl0n1YyAw89iVt/Kz52siIDZ1ju/itDJe/MDOZzNmPqh+3fG7EglBXI8Ppv63lfZUI7Wzvf3PXOKuYNZ9e/0pmEY2CRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZnZooOW; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZnZooOW"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84fa3b14ee1so242381b3a.0
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 22:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786424445; x=1787029245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8XV1qyiW1WN9UH6X3Jv/ZBqv2q+Lebe5phUQECTXzBc=;
        b=mZnZooOWLAP2zjPsXkabxZb0ZtxeKPkDSaYHQrdJOi0OSeMqid/ipu9UHv9wk04Awu
         v5noujmBPEERxJtaXtLWXNInDFKjY92gGzMnFXXn1k8G1kOnMoQT3SY0u3XZMTL0lYxj
         05MujVr5V+yd2Frj5u2dK8Xn3aMyP0c2WrAqqq9lHGOVdb5G/mGAdBKxcnxGqKkw5aVT
         johohxxBlJ1wVNMjs0C+R082c3tub5oYwNue+LO3j6DSLDUWjnzo1QLmYzF3agpXgGHc
         Tk2xbhLTyDiQDuK2TOpDsXYqwaDMmF/LGtA6Wv87PG2xrHgIeXjej1AiHrMTPaebPAdc
         x1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786424445; x=1787029245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8XV1qyiW1WN9UH6X3Jv/ZBqv2q+Lebe5phUQECTXzBc=;
        b=RVKIGLtvDIVddv5AjEoc1VSu5A8qH5taUmRfCNmteKf2m5fu9iynZgqCW2/FM7g+5C
         fyAVVz76YHesAnT/mwz9D19TK0LJPeod6GzsiT32jktv4eJxioig5eGjWZlbqFer5rgC
         PjDmr36Zh17Q9xk2U1+tBXNQQZyI/z2Ko6WeIKTBF+Y+KXYnQ0I90KqX5C44sfKNAEDG
         IEWVqAQszzjK1U86v9m/e8LspmAJUDtzbuBP6KzIuMeYFEr7uVEPOI1DCwlm37/+b+aV
         gBozAx+0+mO1yvJqrPSxYCfEqF3/SUuNrEDvkZ+pd3YPrFjfP6VUA4g3lGseeuZp42Xt
         lNQg==
X-Forwarded-Encrypted: i=1; AHgh+Ro3/7vYARZGlEKaKi38vPj00N9IhKLmHVP2u3wV7KesOgsuHYXkNeHBBPZB3Cf+J9a3uRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaFxQeCgNOpSarQz3jwQMWqDncVLyFzGHfS3rYDMMEne+OtzsV
	uhQyIXkSsnXUsChtGCJxIqeZJeHp9ujoarRROaHEAOHTtwF6G+3j+lw/
X-Gm-Gg: AR+sD12HeeKzlaB+JohCOeuQ9zy/Dvh+aDWbC8NqLHiLvKbCClzMRWcTWgv6MG3ndCV
	rE74lUASYVdh2w59/8pJLkoMuW5sRCcCumjSIGe3aSNbT04SRNcsMfQzgyAL4TmFuJH8LJhuzn0
	/O7N1nARSYvP4YEFHNL/CsD5zcIbOU9kVfLeSL801DellxWJ8Dh9Cg/vU5fSwceL6Nr+43uWvOa
	YpchF+WGJdkOxuXFnnrTTmNj8890smqdg3TqZMPg1hAHwbfhH1nq9Py7Owx0wVhw0ezngeOu7tY
	iUGk5KyHCwJ3JACZvemUUAZmhMlDYWE5+6kmtbOl5Fm98dei8sY/b7vd/b7odg56kog7C+Dzo2d
	I3X3FQ+UcIwCaQl4/eu5mInIgoBxvzHpNNu+5JrtEKnu5vsfnSuf9VV3YjjTTsWp9X7VMB8JXjd
	/DajIT44MD7NoXPhxNdY+B5Ugy6zbjePNNBAAQRv+CGqs6NzV8tz7dbdkWT/k1yWwhoqDhYZUwQ
	O40fa4=
X-Received: by 2002:a05:6a21:3992:b0:3c3:8d86:9855 with SMTP id adf61e73a8af0-3cc2b793714mr1229672637.7.1786424445069;
        Mon, 10 Aug 2026 22:00:45 -0700 (PDT)
Received: from 10-86-27-207.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31c64f0a7aesm585166eec.29.2026.08.10.22.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 22:00:44 -0700 (PDT)
From: Gokul K <gokul02k@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] KVM: selftests: Free the VM when the SEV smoke test's guest completes
Date: Tue, 11 Aug 2026 10:30:28 +0530
Message-ID: <20260811050029.530698-2-gokul02k@gmail.com>
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

test_sev() returns directly out of the UCALL_DONE case rather than
leaving the loop, so the plain-SEV path skips the kvm_vm_free() at the
end of the function.  The SEV-ES path is unaffected; it breaks out of
the loop and frees the VM correctly.

main() invokes test_sev() once per supported SEV VM type, so a full run
leaks a VM and its file descriptors.  Nothing fails today because the
process exits shortly afterwards, which is presumably why this was not
noticed, but the leak also means the plain-SEV path never exercises VM
teardown.

Use a goto so UCALL_DONE joins the existing exit path.  A plain break
would only leave the switch statement and spin the loop again.

Fixes: be250ff437fa ("KVM: selftests: Add a basic SEV smoke test")
Signed-off-by: Gokul K <gokul02k@gmail.com>
---
 tools/testing/selftests/kvm/x86/sev_smoke_test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
index 6b2cbe2a90b7..646ae93e3c46 100644
--- a/tools/testing/selftests/kvm/x86/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
@@ -178,7 +178,7 @@ static void test_sev(void *guest_code, u32 type, u64 policy)
 		case UCALL_SYNC:
 			continue;
 		case UCALL_DONE:
-			return;
+			goto done;
 		case UCALL_ABORT:
 			REPORT_GUEST_ASSERT(uc);
 		default:
@@ -187,6 +187,7 @@ static void test_sev(void *guest_code, u32 type, u64 policy)
 		}
 	}
 
+done:
 	kvm_vm_free(vm);
 }
 
-- 
2.54.0


