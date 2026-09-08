Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2757E57EDAA
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 16:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883491; cv=none; b=iYS62K+SfNpkBGfOZ+ypzSqHg8HHJ0yFVjklJHowtiyPnTn5X0eHmtTgc/NNHz5+A5YolSaYyZ12DbuEdShkyQ8Jv4XaiJvcatgwhNaCQa1/kRd647xeb9hLpAY2WlpHsal2nROSTKznDB5X0zoxC0hCuO/wKfCQsq+MSLNHUWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883491; c=relaxed/simple;
	bh=7yF6qk24zs7GwL8mnF2yvNXOoswzv1qxjksGdcX06Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iEi2Xp1mJqbWYqKU1bf75VfOjGHngXxp4ZypRtz3HAlPeui1lbp94VfHyuwPODT+HhhEDkZJHc7TB3xX8PXauODy3u/4pnSgcKAPqRH4OsEaeAdFSJEO0DMUjkhOAuvfT8gImblLDvJkcyxqaY5+nnb5PUqmENtyJ4q5QeBF1D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7e6KmEO; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7e6KmEO"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6b1b3d7f10eso3319875eaf.3
        for <kvm@vger.kernel.org>; Tue, 08 Sep 2026 09:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788883488; x=1789488288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=51011n7DKhl5RNF5xzZ7n3Z9WFktYO/WAIKo41x7Fmw=;
        b=B7e6KmEOGoI5oH1WEdhVnVY/XNAOTTr+5LSR20Z1cmJQ0l5pzlmeI2lnFebs4ERsTa
         6oeXfLJT4AYN0dU2n68SG0Wma0ugfskJYTFvHfFUJPES/3JaniI0KKwv5Teia2SZc67N
         sitsywkjFvLQkVMgoxp6lcjTqTEZ4JND5QerY9FlYN3b7jg27UC9OQoTu2o7rPa1WpH3
         ZsIwTGdNjmxJVfgc5I5ompvksjsw86zXc1QDa44L0P9G+Dqz4d8bUAwZJJAFkDqFpN5K
         /dxBiBBTh4oKg8CI6MsEl/BVEKQIju+6j0bgt82MFgSANiALaKFMvT/CA1Va0q2cnVa+
         bBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788883488; x=1789488288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=51011n7DKhl5RNF5xzZ7n3Z9WFktYO/WAIKo41x7Fmw=;
        b=IbjmVYDLpYfbwsNrnmtm5dr4ftWQZIudqisP46rrA2HBU03Y6Pk2xhI6sJ5oBYAkDO
         Al7wI43VxJ9ASiserm07+uYZssIxxAaL8MlBWZ2p93vk9/y1t5wpIDApDeX57q1H1VWN
         XeZ16aQ4uQtORSukH7GJ1LyRToTAH+VpqMDsRRvlotjfCMb2vu2I+vHFYVOIiuyzwhsG
         7CoVFHWzPgiMikAH6dymzJv2QXLhwAsZ9PEKePOBymtBxhSS1rxMbBIhAfj+Ml0MG9CF
         i7YPACnh+8XhtNU2X9wcuXZN11OK3nbElBbMprod/Sa4HXXRLOD1RdX8vj5jC6kYGsJL
         KfeQ==
X-Forwarded-Encrypted: i=1; AKwUvBwLJ6jrvw3J2g0sptqTl7mQ0AdvJ1M3UWaLHuF+Yy07ODy94lcsofwtKqfCX56WiNcZuFM=@vger.kernel.org
X-Gm-Message-State: AFuF++n7CKO5Icbx7txSBRAvyJc2gzpu7KDfoYvXkCwISIxg2LdMH8hG
	f/hASworJ9TCfccoUS1RMO1rNfB3aFi2uWiU2Sof27r/S0xWZg/Wqgvo
X-Gm-Gg: AYBFou1ETZ0LXKutrxKFqXrIHFw6y+tnvFn4UQDbmCE4SL09GqH6sViVptzfAjAHfRl
	6ThWISUYwhla/cJGLL+UmJd7+wiT9E2ENy0XgMdso90VE2pd0ei7Eax/RTRY39A80R1eSZ+iJkk
	RNxg2u/gfApZUqE7G07U191CNra3MLMmQbr/3IWKIerFipA54Bb30UyIi0u8J84L2MF5J9NV9d/
	SmVUJtNrJl/aUdSQVz9Z176MrVChmv8W/jxTi/MLTHwUaubwqRDRYgn/7Krt9J8Xgrdj6Jf68jB
	3IGk8bV5RL/Qk4PMeSKOSQo3CeUG04Q18EzwEuckvIewfjKNRUKxdSZV0fgvSexa0LckGoQT7S9
	bxTVcw2ol0kKjMDeKwk2eBL7pqjpQe/xVRv+Dyt27GdW0DE17lpE7fECPx5Jz8PDooL5ZN3oSOb
	fBWuTDCH3AZt30IzL0CfOyInTBfvBYvu5+GsExI5HK4UwfGRQETtqUyeCo7S1EuOhbtyFGvcq0I
	dzcq2zKAQUy
X-Received: by 2002:a05:6820:2219:b0:6b7:8415:d77c with SMTP id 006d021491bc7-6b78415d829mr15051491eaf.39.1788883487843;
        Tue, 08 Sep 2026 09:04:47 -0700 (PDT)
Received: from x1c ([2405:9800:b670:b64b:3ef4:ec38:7826:6c9b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33825669695sm14204525eec.3.2026.09.08.09.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 09:04:47 -0700 (PDT)
From: Tharit Tangkijwanichakul <tharitt97@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	shuah@kernel.org
Cc: hpa@zytor.com,
	binbin.wu@linux.intel.com,
	kai.huang@intel.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	jkoolstra@xs4all.nl,
	Tharit Tangkijwanichakul <tharitt97@gmail.com>
Subject: [PATCH v1 0/2] KVM: x86: cr8 reserved bit check
Date: Tue,  8 Sep 2026 23:04:24 +0700
Message-ID: <20260908160426.6547-1-tharitt97@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvm_is_valid_sregs() validates the incoming CR0, CR4, and efer values on
KVM_SET_SREGS but never checks CR8. When userspace passes a CR8 value with
any reserved bit [63:4] set, __set_sregs_common() forwards it to
kvm_set_cr8(), which rejects the reserved bits and returns early. That
return value is not checked, so the ioctl reports success while the
requested value is silently dropped, and a subsequent KVM_GET_SREGS then
returns a CR8 different from the one userspace believed it had written.

This was found by code inspection of kvm_is_valid_sregs() and confirmed
with the selftest added in patch 2.

Patch 1 factors the reserved-bit check into kvm_is_valid_cr8() and uses it
in both kvm_set_cr8() and kvm_is_valid_sregs() so that KVM_SET_SREGS
rejects reserved CR8 bits up front.

Patch 2 extends set_sregs_test to cover CR8: it verifies that bits [3:0]
can be set and read back, and that every reserved bit [63:4] is rejected
by KVM_SET_SREGS.

Testing
=======
Tested on an Intel host:
                              Unpatched kernel    Patched kernel
set_sregs_test CR8 case       FAIL                PASS
KVM x86 selftests             baseline            no regressions
kvm-unit-tests                baseline            no regressions

Tharit Tangkijwanichakul (2):
  KVM: x86: Reject reserved CR8 bits in KVM_SET_SREGS
  KVM: selftests: Add CR8 reserved-bit checks to set_sregs_test

 arch/x86/kvm/regs.c                              |  8 +++++++-
 tools/testing/selftests/kvm/x86/set_sregs_test.c | 12 ++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.53.0

