Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5B431812E;
	Fri,  6 Feb 2026 09:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770369477; cv=none; b=geU/1hItjedC4L2lqor7XQDyYfwKYnJF2zj3ME5t/LmrlftMlaqxPTAfIITT0PICJQ/dQU8d5akgLzw6NJlprXnR5HMHv0pJjvny1W8w8h6ftt95eB4tqrTZPDB64sHYV/buA0vYEM7NtF9QAb3IoSREc4ygrYPqA1YdnWXsOTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770369477; c=relaxed/simple;
	bh=GqD/vZKOrvhwAYc4AgJtxZJK0os97VUYTFCsqdXb+Tc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j2cZy4A0C8LY8lK3iGZUkmvuZWGUqhH09MUOjBMkE8+XBG3cfTteUGEu3GB9Gy1WDeMkyY5Y3tIvaB1enmqapPkumaFtVJx20znLITw6e1f9UvQu/lJK3x67J5BOH76qYkl74z5COoWb2YmnMzXHjWUx27g8jZUsrX4WtqspiHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsPusBj+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsPusBj+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E68DC116C6;
	Fri,  6 Feb 2026 09:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770369476;
	bh=GqD/vZKOrvhwAYc4AgJtxZJK0os97VUYTFCsqdXb+Tc=;
	h=From:To:Cc:Subject:Date:From;
	b=GsPusBj+hBQuSztv5zfRYAGi1LPV5Yekxu0Cs2rQJhh0qqxpUErU0CY5W97lUg2EJ
	 +v8vDX0A2vMGTzQ6iL8H/n/SV3JYMLmfrv2n5TCpYsy2BqIcf7oo4QpPm8XCup/gEe
	 CL3BBXMWRoaK83Bruut5ZeYZX2kLU6ccs/WtLlJ4x+d263PoHfjhcB/flBuma+nb/M
	 tN+tVt+HHqiSW9QZwiI1Pm6xsjPYD6eYWWUoyfhkDhOm7LQ3/aI7k5izhE8XZjle+s
	 XQQdNK5QHl/5ACAhmbtZDCI50+sDtKO9MlEuPwFJJe5p84z5hh9PwRq0dKbkx6O1M8
	 001BIKbVvPFlQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Oliver Upton <oupton@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Anup Patel <anup@brainfault.org>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Jiaqi Yan <jiaqiyan@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: s390: add explicit padding to struct kvm_s390_keyop
Date: Fri,  6 Feb 2026 10:17:30 +0100
Message-Id: <20260206091751.3973615-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The newly added structure causes a warning about implied padding:

./usr/include/linux/kvm.h:1247:1: error: padding struct size to alignment boundary with 6 bytes [-Werror=padded]

The padding can lead to leaking kernel data and ABI incompatibilies
when used on x86. Neither of these is a problem in this specific
patch, but it's best to avoid it and use explicit padding fields
in general.

Fixes: 0ee4ddc1647b ("KVM: s390: Storage key manipulation IOCTL")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I have a long series to add annotations to all existing structures,
but that will take a while. For now, I'm sending fixes when new
instances show up in linux-next.
---
 include/uapi/linux/kvm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index a68b1741045c..1225fbd017e5 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1255,6 +1255,7 @@ struct kvm_s390_keyop {
 	__u64 guest_addr;
 	__u8  key;
 	__u8  operation;
+	__u8  pad[6];
 };
 
 /*
-- 
2.39.5

