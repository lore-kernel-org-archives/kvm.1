Received: from mail-dl2-f33.google.com (mail-dl2-f33.google.com [74.125.229.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4FB490C08
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 18:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101788; cv=none; b=RzYFtCnzdOlS6omApgc5f4TD3Apo0UBm40UlTeSANv/WAjsXV2v/M81In3z/6l9lDHSzngQKIkvD2hOZ5eUTdMmXQs+1jBPiUI1fwPdvqjV3DvshXDO1szm3qXqbwEh5r1OwaL2C9ofiu/cwtWty9dVZDLwpts3bhQPbjRgEjJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101788; c=relaxed/simple;
	bh=k/cS5EsQzwWWdG/s4MpHv4F471LkL6gXphxZFFDqj2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rc3WWgPjv8l83/dKnAgKIRqf5T7cAOD1Davu6GC3Gh+1eXisgaBGXaUfq82g/sWd+pAnE3+IqgLWtc3Sg7RZz+LET0aOHgAd+K8LSJ5e7w9egVHgU702AKyl6cAuN5Z+9rmsJp6LEGh4qFZMTCW/xFvg1Q+Fzzqz6W4x4DdOFbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLwVMlIg; arc=none smtp.client-ip=74.125.229.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLwVMlIg"
Received: by mail-dl2-f33.google.com with SMTP id a92af1059eb24-1438e88300cso121503c88.0
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 11:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790101786; x=1790706586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iWNx5fuW8O/XLl14TRTirLP01kUfwqrdwxvRgBlb4x4=;
        b=mLwVMlIgAxhRyLc8j1tGXv3aCHBPoDTaFAba3aHnyHaMCn1hWVWE+9qWV8GAmexolR
         3C6pkyxveSuL15DLEZu8OIw0gqDQcxZ8Ls/eOxeDxlC9KJMNdm7OuA2rkYl0+0v98vtb
         00Q04YrDdtemChgpraljzPcxb0SMwvMeyRWaJev891pVr5oIsfQ4ItZ0RL2aqGU0XgDh
         fXRDEeQQrpCyqHaAyUtLS64hXm+qkWm8n99jhCV4ge94YxfhYlR5m9AzuHcy+QUy4ou3
         MqSccS81KOVsXfSsU9BTTeTOEOGX+lSI1qT3kHnWyl/aRySa/HcLe8Ox0cjJeQHJqPn3
         1e3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790101786; x=1790706586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iWNx5fuW8O/XLl14TRTirLP01kUfwqrdwxvRgBlb4x4=;
        b=vW029GZiHVk6O8XEKm9I79w6x2acDlafZV2kIpXCuNDGRNE1sz+QE0spWxdX0UaArh
         MrP8xPtPYxWnPAyPhliNDbLYG7pk7lRlG9ZB4HH5PEDaapJzTVr8yLAs6ZJk7IewhOQP
         RhnmfuvcvHnimLZkvH5EzB1fyPhRi1r/STYsNwmglXZEQfci5IR3LfgpVW34l6LaPrRq
         FCchferGXe3rcCOY4EErNWUpWdFYRtaGaDl3U3AfFV7SyQk0H6jHxwZlX4Nmvt3fbpaW
         3cZnmQwvixRJN9ju8yd/93JkUd7S/NxWTQ2cD+TlJ/Eb0LGxYPhagqOYhGge8snew8NH
         StXw==
X-Gm-Message-State: AFuF++n1klqJ83/jo/QKEaHS7Cni+UN6f9V5A9o5yqX1MPAeIE0QFEth
	0LRB6uR5odueVp9Cf/Nwhy9Q62RoycEX5DDK9Q9fTehMk7NAMukBCS1vpjkGJQ==
X-Gm-Gg: AYBFou1hsORaB74zOgzI+NuruTGnD9UWxwxLZEImd7xS7N3mHnRRzS5Jy3+9h6PIoa6
	7Oi6y3wloyOo8uNXIOidfvJBlqBSkZRZFIE2lPzknBT8ejeE85A6KUdQhaoSXvj3E9zKfUV111O
	BsiH+XGfkzuEYfSvKxsf6X3dnr4ljjgXiXWx0PX4aGwgQ6gXq2WmAphyq+lVF70gufj/lPRXoGL
	fXjbXQYphRIgM+e1HJhlqLYE9biHVdCXu4N7ZBhrx4r50sAYm4iPehSWOC4UQiac2f8hFwJNbcS
	9I4ldNi2Q+7DeTEFJAlwyxGK93BZMifUqzz8Sy2Be40fZoSQJwig9honVCL3ilDEonGwACNYE5P
	Ks7asqislIIKzAl0xiBXC6RBwEmjvFJw9pN9kVC0YbX8kHpK10E0TsRn40ls/sSFM4GdhLrduuP
	35gorUDJL9Pm0jDjj+D/Ed1WxaQu/Y052Cu8q3jM+eSa0y9VIr6TYYv6GLcSq8UGhD6qlvFIBnH
	P53wSukY1JBVo+dVyUx9BxnzAkT0HSSbef/A5WNNgvzwN83PhbDYoRWHIAj
X-Received: by 2002:a05:7022:2099:b0:143:7dea:f6a with SMTP id a92af1059eb24-144f91dd840mr209295c88.32.1790101786036;
        Tue, 22 Sep 2026 11:29:46 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e939fdabcsm154315eec.3.2026.09.22.11.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 11:29:45 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v5 6/9] KVM: selftests: Limit the number of VM creates in hardware_disable_test
Date: Tue, 22 Sep 2026 23:58:50 +0530
Message-Id: <db32438dee67a69609e75d8c43cb070f021137b1.1790101179.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1790101179.git.ritesh.list@gmail.com>
References: <cover.1790101179.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hardware_disable_test forks several VMs (NR_IERATIONS=512). This patch
limits that number to 4 when we know that we are running in constraint
host environment. The number 4 is just a safe minimum when
kvm_arch_vm_create_may_enomem() can be true.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/hardware_disable_test.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/hardware_disable_test.c b/tools/testing/selftests/kvm/hardware_disable_test.c
index 43a36ef3ead8..e90a17b8160e 100644
--- a/tools/testing/selftests/kvm/hardware_disable_test.c
+++ b/tools/testing/selftests/kvm/hardware_disable_test.c
@@ -20,6 +20,7 @@
 #define NR_VCPUS		4
 #define NR_SLEEPERS_PER_VCPU	16
 #define NR_ITERATIONS		512
+#define NR_ITERATIONS_LIMIT	4
 #define DELAY_US_MAX		2000
 
 static cpu_set_t threads_cpu_set;
@@ -127,7 +128,7 @@ void wait_for_child_setup(pid_t pid)
 int main(int argc, char **argv)
 {
 	cpu_set_t allowed_cpu_set;
-	int s, r, cpu, i;
+	int s, r, cpu, i, nr_iterations;
 	pid_t pid;
 
 	kvm_sched_getaffinity(0, sizeof(cpu_set_t), &allowed_cpu_set);
@@ -141,7 +142,9 @@ int main(int argc, char **argv)
 	sem = sem_open("vm_sem", O_CREAT | O_EXCL, 0644, 0);
 	sem_unlink("vm_sem");
 
-	for (i = 0; i < NR_ITERATIONS; ++i) {
+	nr_iterations = kvm_arch_vm_create_may_enomem() ? NR_ITERATIONS_LIMIT :
+							  NR_ITERATIONS;
+	for (i = 0; i < nr_iterations; ++i) {
 		pid = fork();
 		TEST_ASSERT(pid >= 0, "%s: unable to fork", __func__);
 		if (pid == 0)
-- 
2.39.5

