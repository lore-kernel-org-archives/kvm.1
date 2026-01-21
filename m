Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB8543E484
	for <kvm@vger.kernel.org>; Wed, 21 Jan 2026 22:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033531; cv=none; b=Hi710Fnkam94++AYjCfGvGCyuN3sNtRG7zW6PZvzlmgxbenXZXH7jFgj88Jmm/7agienxF+zSEOjKc4rBG9R85LC4U9iV+uuEA3wzcvqI+uhW5KbkwfANOh6dVYeXHE69h9Q0zQvUNlXk8f1SfqZ8ch3uXE6G53Ht7Za5iTk+uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033531; c=relaxed/simple;
	bh=FRcd1avd4PB9PmO5dQgmUicVEjm2xp4QOwjVLS7lcRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PdxUB8G4qME4hz69gBNMahpkmS95fBRZwge1BcJV+iZlnDpzygQCkvD6vPgKStSAF62o+6FY64NY4oW/IYKz8GxVoYAmNHOafib6YJAZxwakd95W3+d93YREtT+80IPyPdBzA5NWr1PNqckGPoPhU7P0alGFvfilbCzIBVI+5dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBrtJQme; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBrtJQme"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-78fdb90b670so2970907b3.2
        for <kvm@vger.kernel.org>; Wed, 21 Jan 2026 14:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769033523; x=1769638323; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I07oD5ozWqHJLvu76IbvCT33HoDsgDmgjc920I58eyc=;
        b=bBrtJQmeE59NXHhsCJs8WCLGtuj91JCF2az84shVTkEM1UofTqyWeNYgT6szujrisB
         gAuWbl1dCQjjBtACh2BEzez10t0APvdfWCrc7jvJTEvQ9MustNZcNJN3M7zAL3naD0VQ
         ZWokXgW6cf6Vdn7H48GQJyJh02hnuz9TlgQ1yIlK9LuWMg22m+h9b10DZHWu6bbzNRhE
         Q7MchC7NftuW1V1oYVPG68VHBM1nXUNblv8ou59pG66xbsl2dnSmoXFybBh+R1/eObY5
         bPbjjC1LauYK1PpmlJwxAXtVaHJrI+eFbEVtD77fIOUU8kuvo+mhojVupIonbP42xDI2
         fI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769033523; x=1769638323;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I07oD5ozWqHJLvu76IbvCT33HoDsgDmgjc920I58eyc=;
        b=DIbsr8dZ61DeLXIoVLwt4vKqvKo33INBM4oK9cI+BchOWQ+qnK3W7Bec8jW/nuuMFh
         FeEnCCi2tMGmE1bMWrMsIT881kW9nz2Ox9dlqT3U3GZ3l+TFP/O44niolBNX0CREUSMc
         g4rvdKdQdQCs9qBnMG/qQyO6xeVu/Z6ZLf1D5BTaHCMbJ40Jmk7DL5Tu9GQdNdXYcf/i
         srBjOaOagL4AcdBWpEC9SqrxpYfyvPpW4YhxaSs1ZVDpOMMd9H1Q98y6kj/bLZVcCGuG
         MUScx6iA2oqHXoTMXZI2HHvpZUGM6vYsU6IZNX/bezFyRe7E1v0zY5jFY+KzzOXHmaHX
         DNkA==
X-Forwarded-Encrypted: i=1; AJvYcCVzXnBnUzwXdyO5mvTx5P38YmixGgFwvhzWi9Nuw7DWr3lFAh4zDxg1tAvI72OIBEdombU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhhLtUgZodb68MEiegcgKYf1chxQv1I2OC9V/bJVQdr8HxRGnD
	1qRJkfpZ7JnvAuLzfQPPA4Owu9ei5SdEK8DP/5q+6ij0V1EuaLQDm2XN
X-Gm-Gg: AZuq6aIPsdQCnBSWft3RQhMzFzGdMxxL2vcyTYljvYWSgMpE9B6ewyIeWWWIV61ej5E
	NrBAm9XT0Twn7/GM1vHBynDkCVqlVTxl66PKJglHmg8kcNHb2HXX1OKdOLj0PQEb2ZuFhNDFaer
	tBdw3fe39OFyGHJeO/ArcdO3tkIs/nfBMZmhbNp/9jlAqpMynCyFpVWK83hf5saHDd7LhZYDjeX
	dfxBFLgB7QawmDDwk6uCbug6PFoG4sQUVEdWCMkPvRi3ftxo0aWkcy245LwLwiPdLPUGIeJAEJ9
	1OzZi05IXWBrCRvy/IuURrzI765NVG/D1BTYQM47O8hwu6Oui6hDq+kmm3j4kvJaSBihjhnp64T
	+uQcGQUgaPpywOQxdtsasFOZmGIbuFWikzKweBNFk/8qco/Vc9OAjPgE1ZTnUherEivI8CxI991
	T4FHCq8Sr5xw==
X-Received: by 2002:a53:bc8e:0:b0:641:f5bc:6960 with SMTP id 956f58d0204a3-64916510381mr11289328d50.76.1769033523366;
        Wed, 21 Jan 2026 14:12:03 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:49::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6494080138fsm2463373d50.20.2026.01.21.14.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 14:12:03 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 21 Jan 2026 14:11:45 -0800
Subject: [PATCH net-next v16 05/12] selftests/vsock: add namespace helpers
 to vmtest.sh
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-vsock-vmtest-v16-5-2859a7512097@meta.com>
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

Add functions for initializing namespaces with the different vsock NS
modes. Callers can use add_namespaces() and del_namespaces() to create
namespaces global0, global1, local0, and local1.

The add_namespaces() function initializes global0, local0, etc... with
their respective vsock NS mode by toggling child_ns_mode before creating
the namespace.

Remove namespaces upon exiting the program in cleanup(). This is
unlikely to be needed for a healthy run, but it is useful for tests that
are manually killed mid-test.

This patch is in preparation for later namespace tests.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v13:
- intialize namespaces to use the child_ns_mode mechanism
- remove setting modes from init_namespaces() function (this function
  only sets up the lo device now)
- remove ns_set_mode(ns) because ns_mode is no longer mutable
---
 tools/testing/selftests/vsock/vmtest.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index c7b270dd77a9..c2bdc293b94c 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -49,6 +49,7 @@ readonly TEST_DESCS=(
 )
 
 readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
+readonly NS_MODES=("local" "global")
 
 VERBOSE=0
 
@@ -103,6 +104,36 @@ check_result() {
 	fi
 }
 
+add_namespaces() {
+	local orig_mode
+	orig_mode=$(cat /proc/sys/net/vsock/child_ns_mode)
+
+	for mode in "${NS_MODES[@]}"; do
+		echo "${mode}" > /proc/sys/net/vsock/child_ns_mode
+		ip netns add "${mode}0" 2>/dev/null
+		ip netns add "${mode}1" 2>/dev/null
+	done
+
+	echo "${orig_mode}" > /proc/sys/net/vsock/child_ns_mode
+}
+
+init_namespaces() {
+	for mode in "${NS_MODES[@]}"; do
+		# we need lo for qemu port forwarding
+		ip netns exec "${mode}0" ip link set dev lo up
+		ip netns exec "${mode}1" ip link set dev lo up
+	done
+}
+
+del_namespaces() {
+	for mode in "${NS_MODES[@]}"; do
+		ip netns del "${mode}0" &>/dev/null
+		ip netns del "${mode}1" &>/dev/null
+		log_host "removed ns ${mode}0"
+		log_host "removed ns ${mode}1"
+	done
+}
+
 vm_ssh() {
 	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
 	return $?
@@ -110,6 +141,7 @@ vm_ssh() {
 
 cleanup() {
 	terminate_pidfiles "${!PIDFILES[@]}"
+	del_namespaces
 }
 
 check_args() {

-- 
2.47.3

