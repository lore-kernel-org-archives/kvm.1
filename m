Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794817882;
	b=Po67Et8O0NN4jlqaPy2pV+vlS+BmAVGxrBLoY445O/7h39stUOTvAKKXCMesSb32dTrk
	 FU6P1yri7l8etFQ8D+G+OF2uR5e6ai3tmgL6jbkadt+5DcKVovxZuflWMgj5/jDUlpClZ
	 kOh0jaNF6+ShMUkV7f50iBPdY2BZmygtlsA7YQYKo+J9uaHMQadM5Fxnzn2AvE+uPdMCN
	 etOIZXnmzh9JoOXmpCXNc65i99qXcvgN1ZqWjwCFlvacvm6dDKpGqdhHIMmlylDmCWpZv
	 X1PG0p/tXsQMGXvvEHBJkih+g91mwfiATYa32KEt7OopKDBPSgOFp0qjtlgTyE42RpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794817882;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pQBiNnGAd1kg+ICIakJM3I6RN733mzmX6uKTF9wOS+g=;
	b=grSOF3Ix1gxbVSYGERVe/CTjKcH6OJbJRFfG+SzIj8WFIqda3hRH+camX8KVsB3G+81s
	 mkoazj5OeZMCz7oDdJezfMnr9stV7A7eeq3KbCAzByAD8DwziqH0HAF6Mg8IXRNw5MCin
	 KblwRqW0L8PKoIIH9f6MDO3NZuKKXNEUJ25TlvkbonPoBQOLvmy+FHKG2TeDqpeJDGkPe
	 gzdugOvtCM9rwgTixdAlWcgx+zxeNhr84wjiNGUzQZB53cfibi+hktYYPfBDLRlvdFNVp
	 1vbopvjOHPZtFdFhMmySRcoqLKUkR/PBDsNOn4qtYwj68X4+9fEMRTOZc7HW1i3ToSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MwHNebYE;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0E8606A31C
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 08:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D0E8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MwHNebYE
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8b271e573adso1399127b3a.2
        for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 00:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794817881; x=1795422681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pQBiNnGAd1kg+ICIakJM3I6RN733mzmX6uKTF9wOS+g=;
        b=MwHNebYEklB08ln8yw4ynzMDLMYp0qumfWE05pPCqDzVnFSV+mu7W6sOj2BV62bW0r
         cvyecPnCziEWljVjQxu5N9oE7KMAz2BlmTiSIYbTy3hUVJr5afnOJ7cbrRnMarm7zYSi
         uz/5KKLMXuN6inmyReAyXPctlTdZSfRYh9Wh/HPy7rk0Wmqewix74t4sF5MWgH/ZTcpu
         jOIrt9xizCQ7likrwhIHSzyV1jfV/leCgK2Xmjh4Jby9HpBUHs+VLmb9fnalLIp5mlLb
         5mcxV0Ybr+vbWHadTwQlgkBKTySi3ZWoW+pOBRWR7oSVMNHF5+7+cl9uIOVr86jrRcxG
         PQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794817881; x=1795422681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pQBiNnGAd1kg+ICIakJM3I6RN733mzmX6uKTF9wOS+g=;
        b=f8tr3mwPyIBzJMNGUYY8gL9/1pRVS6zRmveAjr020DYn208ArkS2wYJHxeXKZNz/Gi
         e9tHLow3kMIjNhCtiN0lbWwLVoXkwcQDRdYBSKbHK4Ceo+JInwYxl6oktie+St+NeXRD
         if+7JHzU3UOct/EZIkhbitKD8RaPjY/mrm48pehEtKptc8KzICQeCfgIC0kYJvnYQJ3A
         U7w6VS6jLwXUGNNtvWbetrnC0MCK5mfHf/dTy2m2Z2qefQqJ4G9Eq2Ofx1oZsXXztV1E
         MvB3wiunrmYIFketSG1yU855eEgg7noND2bhe5JXy7t64pOBOSquMlNo0Jtpk/2Krh6A
         s+rw==
X-Gm-Message-State: APuU4Z9LPm2jzrXp6RhcWfyRRkX6lnQuvowiLeKtcrDI0WQj1RkR8C1s
	wTFs7GwPnhH0XErIMjKDc9zOzYu6AzufnzdIIe17UAUJ+/FwPeIpFBT0
X-Gm-Gg: AYBFou1lZi9+ey45mTglPZpUYZmOms3c0KwrwFldIgPA/Rj9gOq/mPCzR9DdC5wnZAu
	thOb7cS8xju75z+b0Q3gInxHhX3AYTNKaguBVKoi+z/hpKF0e5rjoNf//A9MH3z1+wU6LfUm2m6
	glHZf8Q4T9RseJJHr0JjdCKsHOtAbBjf/32ulLaR8okvsFrpaVncD1zCMZYm6LsdUMDD91Dawnd
	xpT0It2KDQEr2KkoWzRyal3TsTeN9aTkVYgucZD/tLYBZfmaz0J96rD9fcdDfJZEisI0veglMqa
	/z8p69D7kmIchNYjNoK+EylXApbsASWWqYQ0Upf7uYAw88Gsg0t21tAKoHfjrDp4bLSkSdRnlMG
	L1/7pmYcja3DyG7J+PlU4hzL/ROjQiIuqZ/YupvQNKl5EivFKqJmpT9VIggrSC7M+Tzz8BFc8tE
	eghrcbXN6S+ANrsB9oK+6ktxZ/BQvoYH407ShP5UNbDJtLYCqupqhjImjiADflaNwSW10v8xYix
	E59lDAtr8yQFvNhZrU5fDIfnWByIATGetiMi++UHrCFboG0vWcWtmLp0w3rO/mJccDC0TMp3KVN
	BT7dIdAskBJdtkwCTuwIJDjQuEsP8k/rFRj9mPwlKafkWEom6JG9ViLYAT09gj144cTJCv9aYw=
	=
X-Received: by 2002:a05:6a00:92a1:b0:89d:ec58:ce47 with SMTP id d2e1a72fcca58-8beb93aa5cbmr9525164b3a.55.1794817881143;
        Mon, 16 Nov 2026 00:31:21 -0800 (PST)
Received: from FLYINGPENG-MC2.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed2055031sm3572830b3a.39.2026.11.16.00.31.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 00:31:20 -0800 (PST)
From: Peng Hao <flyingpenghao@gmail.com>
X-Google-Original-From: Peng Hao <flyingpeng@tencent.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org
Subject: [RFC PATCH v2 0/4] KVM: Rework how halt-polling stats and per-VM debugfs use memory
Date: Mon, 16 Nov 2026 16:31:12 +0800
Message-ID: <20261116083116.5893-1-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.47.0
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

This series replaces the halt-polling histogram Kconfig patch, as a first
step towards a general plan for KVM stats.

Take a VM with 8 vCPUs on x86.  Each vCPU has 1104 bytes of stats, 768 of
which are the three halt-polling histograms, i.e. 6KiB for the VM.  The VM
also gets ~95 debugfs entries (one file per stat, plus a directory and a few
files per vCPU), each costing a dentry and an inode, i.e. ~70KiB, all
duplicating the binary stats.

The plan:

 1. Counters stay embedded in the stats structs; they're cheap and
    monitoring wants them always on.

 2. Arrays and histograms move to a separately allocated block, controlled
    by kvm.extended_stats (default on).  The binary stats ABI doesn't change;
    the values read as zero if the block isn't allocated.  (patch 4)

 3. Debug-only data goes to tracepoints and is aggregated with BPF.  Adding
    the halt-polling time to kvm_vcpu_wakeup is enough to rebuild the three
    histograms.  (patch 1)

In addition, kvm.per_vm_debugfs (default on) allows skipping the per-VM
debugfs directories.  (patch 3)  Patch 2 fixes an arm64 bug that this
makes easy to hit: nested stage-2 ptdump files end up in the debugfs root
if the VM has no debugfs directory.

With patch 4, struct vcpu_vmx shrinks from 8384 to 7616 bytes and struct
vcpu_svm from 6728 to 5968 bytes.

Tested on Intel with KVM selftests in all three configurations (default,
kvm.extended_stats=0, kvm.per_vm_debugfs=0).  Build-tested on powerpc and
arm64.

v2:
 - Add patch 2, fixing nested_mmu* ptdump files being created in the
   debugfs root and left dangling when the VM has no debugfs directory
   (reported by Sashiko AI review).


Peng Hao (4):
  KVM: Add the halt-polling time to the kvm_vcpu_wakeup tracepoint
  KVM: arm64: nv: Skip nested stage-2 ptdump files without a debugfs dir
  KVM: Add a module param to disable the per-VM debugfs directories
  KVM: Move the halt-polling histograms out of struct kvm_vcpu_stat

 .../admin-guide/kernel-parameters.txt         | 13 ++++
 arch/arm64/kvm/ptdump.c                       |  4 +
 arch/powerpc/kvm/book3s_hv.c                  | 11 ++-
 include/linux/kvm_host.h                      | 24 +++++-
 include/linux/kvm_types.h                     | 10 ++-
 include/trace/events/kvm.h                    | 16 ++--
 virt/kvm/binary_stats.c                       | 29 +++++++-
 virt/kvm/kvm_main.c                           | 73 +++++++++++++++----
 8 files changed, 148 insertions(+), 32 deletions(-)


base-commit: d21eef2084a9af87ac2a783bc7c2b175ba114e4e
-- 
2.43.7

