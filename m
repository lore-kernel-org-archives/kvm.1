Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B548743E49F
	for <kvm@vger.kernel.org>; Wed, 21 Jan 2026 22:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033531; cv=none; b=Vt5IxMkWRI/+tGOHI841LA/kPf3DiPAcxQuksoExxFvmqkzx43AoX2KIPfCXlZKmMkdMmwsOEwq1a03X9sUHmS4QTBPeDA7t/eDzp9wRNbvDQCLYkTIwfcxwEGkhtEQVcqsXFvkshTP/CSmVXKYATrZyO/sy0WHNmdPS2gWqeV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033531; c=relaxed/simple;
	bh=Uqeotcna4sKhnpsKpqu9ZIU7Rje31wAi6t7AlhVdLKg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZE+Q876IKkq12SGfSo9WsklI+Nwa6oaSGwvB8W+t+a6CJOGWUI8yPbs8//C3iBX+UVXjSQ6FSm8K8EjrOTfPLL/JHC/E95XWCs9MGJlGYxeEbTS+r2c4KqMWrOury0Cp0G/mVK4v+Bn/Zd01lmGytJj2FAKQPPbgZTp94saVflA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ac6xwi25; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ac6xwi25"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79419542b12so2167257b3.1
        for <kvm@vger.kernel.org>; Wed, 21 Jan 2026 14:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769033525; x=1769638325; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dUBBU245D9tnMf9A+ObhwqUmHTyrgT+5VJLzKaof8o4=;
        b=ac6xwi25Y8Wq776eJFc2RatKWt5zUDZ8UQLbtrqJJEmnxuq1B7TcvHdRc5XKylq+px
         0bTYmaMcTCuje1cog0N4/smSuX80+iQ5O2+JSfSQrEx3ywQUxf0RW1BydYtla/Yh3jd6
         dqxZYBZgPz7EBGH/npCeBteSUymHeqv5A14FcIvl/RCNhBfon4f1KF7H6VVqQLVrz4l8
         HOFRWqptsKonbICt248uahT2ap/Rj1aGhkNpv5NvAPqIqn8uOetowbg3eW6TaMBOqm1c
         PZwXY1KfICxR0m7+qtFD08TrBQZ6Lz2MrA441ADNoJsGN2AvwxEzFDQwnT73CqJxDECt
         paaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769033525; x=1769638325;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dUBBU245D9tnMf9A+ObhwqUmHTyrgT+5VJLzKaof8o4=;
        b=DmVMboJqB0kjK+ZA7ogjgJINFNU0sch/pDk8mtNq46Bh/UUb2+iBoIeou20uuCWI6W
         0qGwvEw86992KXewIu/X9u13sB6Y2jcbKvjAITY8Dz4CItZMB3IJ/Vy2Xise8pp3t9x5
         8M/rVnLv78QTh1Yrt4FwHfskeR/ggZ3nq8Hi1XoX7o+BsrJx3MFm52UV0hYbiYjC6Ieo
         EKPYbJxTffsuFSINaxTdnAEJtlTLLw/uLHjclZqMLxop7bDWgtNO2nWjpC7HZw/PkR//
         kOChh2L00vBZH1n4ctwLkk9z2NIap/vWTy4hg19H1REYNmtlhmBEfA7TZiHNKsKtVB6Q
         8WuA==
X-Forwarded-Encrypted: i=1; AJvYcCXqarFidBFQ2mx5tEuFlAwwzPXd2LbopASRK74h25wQCBiIbAMpluHmjfAFkiKLL8ZDEbc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr3P+GcA1LP719VKilk9kq2VruRoNypL6cUD7nxf8VDzNa/83/
	fNVY7LMGDfwuFFrRP5kt+urEaT4jIkuwlGKzCrw6DPsDNRtL+zU5fMpp
X-Gm-Gg: AZuq6aJwdZYpGAbYwtnH3UStikcFLI6W/vr07B4dCWaiuiVOzPsZqClV/Ff9pNcFuza
	wfp1o8zd9+mkZv+ooDLFHxuRBcM8HWpws+ub5bzDv76ExiOoyqkIOSxet8vUWnT12dL7oe1CEcJ
	GE1DaiYhmA2FjP5lnoxnK3HmNk5Zl6wzIZAPD44F/sxy9mM563ndevVrIWJWUXqcBQaLx746qSK
	NDG+P8741LNZPRuIEtBXFtck/t/xDiOS+luOqE0b4/WCLcedvTlHe1DVpA9Jtj/5k20yavgetzh
	G3GzJNd/saskPLkfXogtswZ/Xdb0q1RuUkG0u/OH4FGAAFnGRMACBQysA0b6Usc8GxZ0HP1oftK
	cuHMmOgu3FlKoT9Y0Qhbn8bnCq7cghqSBqTORGtUcvbuXQ9J+pGTC8yiSpX3XI4W7tJfllSDsz0
	J6p9QzdcvVVwhOzNZhenen
X-Received: by 2002:a05:690c:d1b:b0:786:6179:1a47 with SMTP id 00721157ae682-793c6803c15mr130911767b3.44.1769033525375;
        Wed, 21 Jan 2026 14:12:05 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:50::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c66c729fsm71255977b3.12.2026.01.21.14.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 14:12:04 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 21 Jan 2026 14:11:47 -0800
Subject: [PATCH net-next v16 07/12] selftests/vsock: add
 vm_dmesg_{warn,oops}_count() helpers
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-vsock-vmtest-v16-7-2859a7512097@meta.com>
References: <20260121-vsock-vmtest-v16-0-2859a7512097@meta.com>
In-Reply-To: <20260121-vsock-vmtest-v16-0-2859a7512097@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, linux-doc@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

These functions are reused by the VM tests to collect and compare dmesg
warnings and oops counts. The future VM-specific tests use them heavily.
This patches relies on vm_ssh() already supporting namespaces.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v11:
- break these out into an earlier patch so that they can be used
  directly in new patches (instead of causing churn by adding this
  later)
---
 tools/testing/selftests/vsock/vmtest.sh | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index c4d73dd0a4cf..4b5929ffc9eb 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -380,6 +380,17 @@ host_wait_for_listener() {
 	fi
 }
 
+vm_dmesg_oops_count() {
+	local ns=$1
+
+	vm_ssh "${ns}" -- dmesg 2>/dev/null | grep -c -i 'Oops'
+}
+
+vm_dmesg_warn_count() {
+	local ns=$1
+
+	vm_ssh "${ns}" -- dmesg --level=warn 2>/dev/null | grep -c -i 'vsock'
+}
 
 vm_vsock_test() {
 	local ns=$1
@@ -587,8 +598,8 @@ run_shared_vm_test() {
 
 	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
 	host_warn_cnt_before=$(dmesg --level=warn | grep -c -i 'vsock')
-	vm_oops_cnt_before=$(vm_ssh "init_ns" -- dmesg | grep -c -i 'Oops')
-	vm_warn_cnt_before=$(vm_ssh "init_ns" -- dmesg --level=warn | grep -c -i 'vsock')
+	vm_oops_cnt_before=$(vm_dmesg_oops_count "init_ns")
+	vm_warn_cnt_before=$(vm_dmesg_warn_count "init_ns")
 
 	name=$(echo "${1}" | awk '{ print $1 }')
 	eval test_"${name}"
@@ -606,13 +617,13 @@ run_shared_vm_test() {
 		rc=$KSFT_FAIL
 	fi
 
-	vm_oops_cnt_after=$(vm_ssh "init_ns" -- dmesg | grep -i 'Oops' | wc -l)
+	vm_oops_cnt_after=$(vm_dmesg_oops_count "init_ns")
 	if [[ ${vm_oops_cnt_after} -gt ${vm_oops_cnt_before} ]]; then
 		echo "FAIL: kernel oops detected on vm" | log_host
 		rc=$KSFT_FAIL
 	fi
 
-	vm_warn_cnt_after=$(vm_ssh "init_ns" -- dmesg --level=warn | grep -c -i 'vsock')
+	vm_warn_cnt_after=$(vm_dmesg_warn_count "init_ns")
 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
 		echo "FAIL: kernel warning detected on vm" | log_host
 		rc=$KSFT_FAIL

-- 
2.47.3

