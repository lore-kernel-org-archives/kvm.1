Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFD237F72B
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 06:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382421; cv=none; b=NtqPfFbgmpBtnTVSPBz6xgrycfuoLLzBsJXnAtgn47WPFTnWTiDTDrV8wK68qgJ7HNPHhs+nnsAs3Omy9y2N3zybiHcmNSp3KizltdmFv4KAVeSz0SFveY+V6aEBx3HDW6HZj6g9Mp2LaVNZzN9nOggOwcGP+d7uau9GZcNZ4Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382421; c=relaxed/simple;
	bh=8rmlUkLqBvtb8VE4ywj3txjREoaW/02KSXQr9g1SYJE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=btE2dzaGWIoOdunGduTGvTw7WKyQKbM9DDRjksRRPjWBVaBy2GItUEdb38ky/+V+dQeJBvuhvcvhYVigOsR8HOw40DgBuraJeJOdDMmMr3QI3TcyVVzFSvzfKru4tJRKHMrL98HL5w31BNG13WDd/URg+HmrmEMW/tcNAyRLO8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KE5Al0WP; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KE5Al0WP"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3598733bec0so12530543a91.2
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 23:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773382416; x=1773987216; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P6lTN64xldfnaq1LQEg2mnalldlsdX5OYA6deCZIOs8=;
        b=KE5Al0WPJqS/e9TQX5UQf3lTm0FVUV/q6eEzLgD0jiNJHrHQLEv2Bv53GJFmwS1iUa
         ilN5jC6XqDmUBVLnVbJf98aUioGhmCU7psUDCe4I+9YCXbWo8NF+NbsgcP8G5wDhdvOE
         5qCTn6jYU9M6mz2GfF+2M8mxdGfFzKtEYfoK9fG/11viUTofqByDm+WrvEohJZJMQk2i
         lDdDQtv0jy1UeZSI0A9MJXRyqE9ZzYS2Vio1ACHAdt/s6APGN33SxKe3PROBgun4t2x1
         c31dOe3EpAc+EIkc5Oc9pD2kkrUu/lhpTn2YSF77EFVpun9HA5i9QKgtCdo09TOZIFfJ
         0AIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382416; x=1773987216;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P6lTN64xldfnaq1LQEg2mnalldlsdX5OYA6deCZIOs8=;
        b=izZ+0LQAc5CaOTRPW/ldpOXJCG3kPGqme/xpA1TDxuUiW7AhA6c3yy4eMtXTCoO+je
         G4lgNYLISYnEmmrGkc8VRHHC3lle+Lr6SW9vrTzaG+dYfMlXCoobChiuKQhn/538wPc0
         h+FpwzlH5uFHdcrF0ZAB0PbNbkTgwGjnrpSFbjDqymh7uXYh2EZZVv90WToG9ATgF0km
         tp1tjG2eHO5ZGWi6cQ1KetuDP081UeLYXhLNqXdULeXRWxdvcRP3x1MBfW4u5naUMwt5
         ptV8/iiPpNkA7ukLoy8dUs3r9txctW3BQ+FI8d517bz/sPoIpVuH64D2e5MolGWvhMiV
         MGKA==
X-Gm-Message-State: AOJu0Yz5rDRgDJwZyMGXKzKS0ZelME71zzPRoaYZuGqvpuAiTidInAoE
	Y+GAsvpHM+5MvjFgkttg4QL0cbMeUXIArSu/XoTpNHrmCQ9DopDYGU1i3zOG3+6JpOealWDv3yT
	R/7RcZOnnLty4pRIAqjTqJw4FLQ==
X-Received: from pjbie24.prod.google.com ([2002:a17:90b:4018:b0:359:8bb2:c98d])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3501:b0:359:fa1e:2bc3 with SMTP id 98e67ed59e1d1-35a21ea5dbfmr2042093a91.6.1773382416219;
 Thu, 12 Mar 2026 23:13:36 -0700 (PDT)
Date: Fri, 13 Mar 2026 06:13:08 +0000
In-Reply-To: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773382364; l=2496;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=8rmlUkLqBvtb8VE4ywj3txjREoaW/02KSXQr9g1SYJE=; b=psSIWaz0KuTYFKMs6GurXm+OD/Yge/qNJfZCqk2NcpYOyItN2iaatxc5TI3jjqSWzjZSgXrRU
 VJ6ONZ7JBVlCrVlqUIszI5Iuk7bh4fnJnGmQiv+NDrlA6tPu9EyikvF
X-Mailer: b4 0.14.3
Message-ID: <20260313-gmem-inplace-conversion-v3-29-5fc12a70ec89@google.com>
Subject: [PATCH RFC v3 29/43] KVM: selftests: Reset shared memory after hole-punching
From: Ackerley Tng <ackerleytng@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jroedel@suse.de, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

private_mem_conversions_test used to reset the shared memory that was used
for the test to an initial pattern at the end of each test iteration. Then,
it would punch out the pages, which would zero memory.

Without in-place conversion, the resetting would write shared memory, and
hole-punching will zero private memory, hence resetting the test to the
state at the beginning of the for loop.

With in-place conversion, resetting writes memory as shared, and
hole-punching zeroes the same physical memory, hence undoing the reset
done before the hole punch.

Move the resetting after the hole-punching, and reset the entire
PER_CPU_DATA_SIZE instead of just the tested range.

With in-place conversion, this zeroes and then resets the same physical
memory. Without in-place conversion, the private memory is zeroed, and the
shared memory is reset to init_p.

This is sufficient since at each test stage, the memory is assumed to start
as shared, and private memory is always assumed to start zeroed. Conversion
zeroes memory, so the future test stages will work as expected.

Fixes: 43f623f350ce1 ("KVM: selftests: Add x86-only selftest for private memory conversions")
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/x86/private_mem_conversions_test.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
index 41f6b38f04071..47f1eb9212591 100644
--- a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
+++ b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
@@ -202,15 +202,18 @@ static void guest_test_explicit_conversion(uint64_t base_gpa, bool do_fallocate)
 		guest_sync_shared(gpa, size, p3, p4);
 		memcmp_g(gpa, p4, size);
 
-		/* Reset the shared memory back to the initial pattern. */
-		memset((void *)gpa, init_p, size);
-
 		/*
 		 * Free (via PUNCH_HOLE) *all* private memory so that the next
 		 * iteration starts from a clean slate, e.g. with respect to
 		 * whether or not there are pages/folios in guest_mem.
 		 */
 		guest_map_shared(base_gpa, PER_CPU_DATA_SIZE, true);
+
+		/*
+		 * Hole-punching above zeroed private memory. Reset shared
+		 * memory in preparation for the next GUEST_STAGE.
+		 */
+		memset((void *)base_gpa, init_p, PER_CPU_DATA_SIZE);
 	}
 }
 

-- 
2.53.0.851.ga537e3e6e9-goog

