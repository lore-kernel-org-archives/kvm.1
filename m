Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D58514ABE
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406114; cv=none; b=jwtxOkkEppwxOL0WRFWKAFPgCpSi717KFj7bbOZdoOA5gjf8KUF+2VWdsuCOwlUnUGOsBZRKKw0kyM0OjnoxO9fydAxam2JZaEtB4Xc+zoeUEp28yIEGIIIoPWsnOaZe5BfdElv1/2/VnKCvcGGu3+y7xNKLWNdx9ou5bSLhCTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406114; c=relaxed/simple;
	bh=8N4VCo1kIZzKgvUZK7T4/k/lJmdWjCt0QuSXBEDCSMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/ujECj0ufRPzBYA3f3j3Rb+oUceu3+467rFisZa8a7/a1SCOqhuFxc6YK20vBU54Nsl586XmArgMeo5ZE7jHlJtQr8KOifbMvLvhYbBtofXx9z66yEgaBQ9Gnmx6NH70poGEPXATF4MOXPh1vU6Nx8baNJG2QPeENdJBIrm7nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtTC1EeE; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtTC1EeE"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33bb1a50f6fso848869eec.2
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406112; x=1791010912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JM/7bmm5w0DrybT6q8HGQqwVn9iraKsL9TCtK46LPGc=;
        b=OtTC1EeEDwg6Yj8Ctxyz1CDi+/wAWrWCyjRCyUJeQU0mNljfO6r0R4fETrr3u7aHYk
         z4RghfeF2cDC6QCw/qkmdtJ2CVSBZT7b9WXFsP+TFH7M2764L5qa/8R/fvCxRKmA2YJ7
         wZ1MbFCfdOxvP2koiNuwJd3KAGCbKeNeVQd3D8X9PqsYrL1yhUOdX5Dnd0VY007vnSHG
         pnyQz8tSARBxhK0uzvwXN22YY+J3xITE6wdRQfSImXQRLXNFLKrGyDJhJqN6fVOXzaj1
         5OHcDB1hoMjGS7PjfKoPzk3lzHKpRRqtDcnQyi0+BYewoB7hppsk0PN5gpQAJvy/YLHh
         fcfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406112; x=1791010912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JM/7bmm5w0DrybT6q8HGQqwVn9iraKsL9TCtK46LPGc=;
        b=KYZBz0AMeeugCJWGPD8xw84t8vikVsjgnKjTsDCwyIPYGDHSSGo/FOBsG9f40OXwdx
         utLC+PZghhXg4hyEqtG9U0pBFfCy7rzpUayVbaH+sFeZ2y4sClYEg6cls1jm9sJJzabq
         LA+voEm17IM0hXk3SdYGGtV5El6fcu/QwG3pj1nSqV6fJ5qzIRmqifY76phXTn6k31t8
         Wv5zc8sOcmbh+i2+ylL2NNFzBmH94YgSH7/SC84vShfGHGql5B/Wrg8LAA9KtnJwswvd
         vDm3N+y1b5u7AC6+pPteHH3Js2m1gDjSISTK86Qqv/eQFUde1w4eHKdm9TAICCq7oq0m
         KhPw==
X-Forwarded-Encrypted: i=1; AKwUvByzThdVjAq2PSaioMfn3j8zm35UhVDg4gGWNc34uWb1rNIiqQ0PrURUaURZomhAbYfMx0A=@vger.kernel.org
X-Gm-Message-State: AFuF++nlLQDxZy1Y6Jyyakz1SIxwlGhaor5NK4P/9WCWF4LnYeGlXgrk
	drTkd04YGKLyKu46pwerudgvTkJ6YExgD9qvkFTeizVJCcFLhgoFIHnj
X-Gm-Gg: AYBFou28n1eJCTFoa5HZkUBevG0s/Y6IKSHnujFgwlyEwVdxCqcRJe8EkDQeNrqeEQt
	cLK00fDm1CCILD+eif6dsdkzXt6+0yRm884xJU0GTaLnjSomIhgWjUxdImhXJY33zauoYmoVOya
	u8oRypAQLHwvlg3uCLf5u8TKE8BR6Q7PyFM61aWgyEt8+0auIFH0i/NfV877EuBtXCP6+5XkGXB
	LfjykPF77Ub971EaUdKrJddtdKI7Fl73ag0ZO9JTxIujv9sukLYo2dril0lMX1UUbwNBi6PrTW4
	HyifCVEh+/WQ/RIzJe724V87cwQPxnTHDpVb1drAund5ei7SSqduFQLXhJpXIYOkJbW2+u4jxk0
	PBYLoxfhXYgwfEt5SUq9eqn2ee5bGa1v/e+E6JWMkVPpuCFDYpeG+aKjz2Jn4OR8Y4aA6w9390I
	5CxLPSYaP64lLwgD7NGvo4IgcGBUp+2kl8T6TfQalR1N2bPYLJKmu+j86EslOfcjnmE6zMiJe6r
	8p154UgwwRsvd1cuOya8dzVjd67Sxw=
X-Received: by 2002:a05:7301:4281:b0:33c:1521:89aa with SMTP id 5a478bee46e88-34271a8deb8mr2052589eec.24.1790406112321;
        Sat, 26 Sep 2026 00:01:52 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:01:51 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Fabiano Rosas <farosas@suse.de>,
	Laurent Vivier <lvivier@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v4 12/55] target-info: add target_is_any()
Date: Sat, 26 Sep 2026 15:00:11 +0800
Message-ID: <20260926070057.1234-13-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926070057.1234-1-luoyonggang@gmail.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

target_is_any() returns true for every TargetInfo. A type that is
not target-scoped can use it as TypeInfo.is_available.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/target-info.h | 9 +++++++++
 target-info.c              | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 89656da1ca4..3bbe1d9b607 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -53,6 +53,15 @@ const char *target_cpu_type(void);
  */
 bool target_big_endian(void);
 
+/**
+ * target_is_any:
+ * @ti: TargetInfo to inspect
+ *
+ * Returns true for every TargetInfo. Usable as TypeInfo.is_available
+ * for types that are not target-scoped (TYPE_OBJECT).
+ */
+bool target_is_any(const TargetInfo *ti);
+
 /**
  * target_is_base_arm:
  * @ti: TargetInfo to inspect
diff --git a/target-info.c b/target-info.c
index 6d57cad5d33..ad93a4b125e 100644
--- a/target-info.c
+++ b/target-info.c
@@ -96,6 +96,12 @@ bool target_big_endian(void)
     return target_endian_mode() == ENDIAN_MODE_BIG;
 }
 
+bool target_is_any(const TargetInfo *ti)
+{
+    (void)ti;
+    return true;
+}
+
 bool target_is_base_arm(const TargetInfo *ti)
 {
     switch (ti->target_arch) {
-- 
2.52.0.windows.1

