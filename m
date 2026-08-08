Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B923F3A7595
	for <kvm@vger.kernel.org>; Sat,  8 Aug 2026 08:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786176684; cv=none; b=OMDwsTRYJYmZhRUSnOI3eDcb9repcmTnl9EItOjf0aIK3sXWFWjwcmsmzS3U7Q2wC0iWvzhYcua7JnHSJwCNWUaMz3UD3JF3iSGXI18tto60zlec0bRZAyQJ7/zHt3XrQUA58xiWVPbYJp/EcCga3ZSvbWHQ60y5ooRp2jS6kUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786176684; c=relaxed/simple;
	bh=kz5eF8EgHJZV4kT1Yjijkfp28Af36RtKI66Pm5tq4pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hggCc/vlXoeWKs4Lj/0g8+SOGCq6Owkw6L8JaDvFbYVNljxCANjrO2bF+xM0MWCs+xjGRaHjNg2854qLyAzM2iNwfoDWUC2Uu1lNi5Bka3ekjwTmnAUJAeZ6oqOQ1AviDYYrZGL5x00ykIUK4zTr6QiyoysVRIvy5vVS1myeJmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRjWmcoJ; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRjWmcoJ"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ca88130e09aso166655a12.3
        for <kvm@vger.kernel.org>; Sat, 08 Aug 2026 01:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786176682; x=1786781482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8XV1qyiW1WN9UH6X3Jv/ZBqv2q+Lebe5phUQECTXzBc=;
        b=SRjWmcoJZDdTSWMc1KgFI003tZZFY9UHqKiudZzgwwHYlUfmT2I4vylEyI4jFCCmkd
         Gjy71Rb8UmuhaaGnP7F10PDbzVrqYN7i4/usN1kAJsScZEOmDpxWVOQd782znwuEMYPb
         IP3d7BbSn0ISI4zyjTLlbY14zEWls2xSlSG9+xaE3lL+fx1Px2Hj22GCFaROEdFUlVuM
         WBG83zjUXY9dRQCn6dcoFZy0A5MZwySHwaudrGxN3QPxKKWsJ5XCg/SWYJGKGC9/n+zt
         QFesoXVbUy2kial5ybp53Cbn+du8VfTbzyBy/udsUlHm+q++VSt1bLRNjMb5ORKtvdWI
         zVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786176682; x=1786781482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8XV1qyiW1WN9UH6X3Jv/ZBqv2q+Lebe5phUQECTXzBc=;
        b=APGnM6DbB4nNgGg6xqp78TA2Bf4UEXRhCa5OjnQyELfck4saSMtkSElFDhkIwmXqJw
         2449T1uxgFSzXy5yJgT2faYF6ywRTSa6SC57yqZ2BwdrIhaJo4V0i0dFLU7tMK9DEca+
         pprGUVlheLI6EK6seXqyrxVy5c2xBkSu78++BWBSicCkdLEaXeWPaiYgDxu/X7h7x9JK
         Au09bM1xLfHW8DeUFjjdh6DyFzciT6wCI+IhzHsWsWmA8qECsIlwA0tkxdOXZ7EUt4Nx
         lD+GSJQ54QdnaVPlnfyKlyAjE80lSbdRVjTCnzoqds1cGSC3mFYrbsyY29CX4DcT7PP9
         cnQg==
X-Forwarded-Encrypted: i=1; AHgh+RruIv5k3MzZJX6yvLHP/KsQD6lI9+f7DNrAqbSwQUZoS8TbxFLr2Uqr0Na31o0PghkFPGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0BH+VHXttUt5cjFlAGpw23JhBL2Y0cQ21TnBlmQksIjPNR5/p
	Zm2GQPftZPKskWrpY+W7ki4BhvIXpD9VJQhF4acBnkEVCIARvl9Cz8xZ
X-Gm-Gg: AR+sD10VCqiPgge0qsLhlkvRTAVpQl+hmI45faHW0kgKA16uZLgqsseRquKUyDTPmk4
	HJ76oPXx2PrvInqshaK0LnfVFh7W9LLY4+fHKL4jRHyK5wW2mgB8SJCpu87kTOh7oMSA3cr06/P
	8oBdfsv5AzouE8Bo7wIOYZ95l6jYoj/921MltkujtV4ZoC52+7P4E1wTHkUOvU2nO3ijOTD09Fq
	DQxrooLaFNrX/HP1htEzbpMh46EbbORUtsOwcbseAcQJvFu6tTgxxeRo0Irlnk+3Afnp+tihNfN
	6fnCibhBgnInw0DgcqSNYMHB41EcxTBxkal5CONk8/ojiSdeAkVhHVUQ9SgPXuN/QLpIoX8Jv+/
	4N7/04jP9sevSLCfbLZL2UXtaYsK8yZptJCQu4XcpRMWSn/oK+ht2hnqXENXE4xXC0jwzr5xCeD
	C9rnp1fpPIIPfY5wWa5h7Sv8waq+Eqn2I5DNpeC7hVRtxMPR/zz2iS1WRDKl+EfHjAQuqS3aSrR
	g==
X-Received: by 2002:a05:6a21:6197:b0:3c3:7891:6523 with SMTP id adf61e73a8af0-3cb85ffd1b7mr35612051637.34.1786176682050;
        Sat, 08 Aug 2026 01:11:22 -0700 (PDT)
Received: from 10-86-27-207.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141019b4244sm13957833c88.4.2026.08.08.01.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 01:11:21 -0700 (PDT)
From: Gokul K <gokul02k@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] KVM: selftests: Free the VM when the SEV smoke test's guest completes
Date: Sat,  8 Aug 2026 13:40:49 +0530
Message-ID: <20260808081050.408657-2-gokul02k@gmail.com>
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


