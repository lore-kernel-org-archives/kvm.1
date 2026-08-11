Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C394229D26E;
	Tue, 11 Aug 2026 00:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786408294; cv=none; b=a+oo+XrPIu07DRIAkOsHZK0gdtwit3D8rIbDXE05pSpkFhlm5YAvRsH+Pn7WKFjOoF1TBo0QJTgUSxlcheZbJ+BRf0eE1KQ+OVNRvz6GuetTFPB4Z7fcZsS/gTNRVo5RHK2Wx3fxzkXhIg0GT3evSFDZdx2Qx42QjldhvmfWlQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786408294; c=relaxed/simple;
	bh=eCAWpeoXSR0PzeZq7R0A1GNgowqXnKT3dZkkK+P7S08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SYbAbMgV/RJ+/RYM8A6Bg/+hbIs5qd43UE7ailO8NWw7nYvIVy7R5J1aMyoLmPp6e8SY3cl9f0ByQIIiDg/+X3xNqrsyTZbBoNhe2MajkMJaAxDatpbNifk4gWgtnNufevUmuXIK0q0g1foNHic9YkasPVt5B2HETrMoHpvhUWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Dg6XwPJo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Dg6XwPJo"
Received: from fedora (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id CD95D20B7167;
	Mon, 10 Aug 2026 17:31:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CD95D20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786408269;
	bh=lU/xMDy6fjUV7zy8ApdvrxOOcU8WJVR9HODtMyTxJ+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dg6XwPJotosaiYBpdURqVWYUyyKMKq3gR/eJM1MgYY0gyo4qy9UwNXrS6LOYpWLbT
	 hdCKNX3zqXhKh7jD3kasEUscT1FS8xx+TxV2QNHyMg9py370v9cbJKCmlU14IGSmHe
	 dV+f2W4vimQUDWP4hXQ219u8r1wDX9uGH1sf1+k8=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 3/4] KVM: x86: add VTL-call state to struct kvm_vcpu_common
Date: Mon, 10 Aug 2026 17:31:13 -0700
Message-ID: <20260811003114.30107-4-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811003114.30107-1-snambakam@linux.microsoft.com>
References: <20260811003114.30107-1-snambakam@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the shared state used by the in-kernel VBS VTL call/return handlers:

  vtl_call_ca       - guest-physical address of the shared calling area
  vtl_call_pending  - a call arrived while the secure plane was booting
  vtl_plane_ready   - the secure plane has parked in its VTL return

The fields live in struct kvm_vcpu_common so they are shared across a
logical CPU's plane vCPUs.
---
 include/linux/kvm_host.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index a61524ab0d94..61bb59c50ae6 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -386,6 +386,11 @@ struct kvm_vcpu_common {
 
 	bool plane_switch;
 
+	/* VBS VTL-call state, shared across this CPU's plane vCPUs. */
+	gpa_t vtl_call_ca;
+	bool vtl_call_pending;
+	bool vtl_plane_ready;
+
 	struct kvm_vcpu_arch_common arch;
 };
 
-- 
2.55.0

